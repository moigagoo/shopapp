import json
import strutils
import sugar
import options
import lenientops

import jester

import ../../db_backend
import ../../models/[user, customer, subcart, item]


export json
export strutils
export sugar
export options
export lenientops

export db_backend
export user
export customer
export subcart
export item


router customers:
  post "/":
    let age = if len(@"age") > 0: some parseInt(@"age").Natural else: none Natural

    var customer = newCustomer(newUser(@"email", @"token"), @"name", age)

    withDb:
      db.insert(customer)

    resp(Http201, $customer.id)

  get "/@id":
    var customer = newCustomer()

    try:
      withDb:
        db.select(customer, """"Customer".id = $1""", parseInt(@"id"))

    except KeyError:
      resp Http404

    resp(%* customer)

  get "/":
    let
      perPage = if len(@"per_page") > 0: parseInt(@"per_page") else: 10
      page = if len(@"page") > 0: parseInt(@"page") else: 1
      limit = if perPage > 0: perPage else: 10
      offset = if page > 0: limit * (page - 1) else: 0

    var customers = @[newCustomer()]

    withDb:
      db.select(customers, """TRUE LIMIT $1 OFFSET $2""", limit, offset)

    resp(%* customers)

  get "/@id/cart/":
    type
      LineItem = object
        qty: Positive
        item: Item

    var subcarts = @[newSubcart()]

    withDb:
      db.select(subcarts, """"Customer".id = $1""", parseInt(@"id"))

    var
      lineItems: seq[LineItem]
      total: float

    for subcart in subcarts:
      lineItems.add LineItem(qty: subcart.qty, item: subcart.item)
      total += subcart.qty * subcart.item.unitPrice

    resp(%* {"total": total, "items": lineItems})

  delete "/@id":
    try:
      withDb:
        discard newCustomer().dup:
          db.select(""""Customer".id = $1""", parseInt(@"id"))
          db.delete

      resp Http204

    except KeyError:
      resp Http404

  delete "/@id/cart/":
    var subcarts = @[newSubcart()]

    withDb:
      discard @[newSubcart()].dup:
        db.select(""""Customer".id = $1""", parseInt(@"id"))
        db.delete

    resp Http204
