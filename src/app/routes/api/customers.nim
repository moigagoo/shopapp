import json
import strutils
import sugar
import options

import jester

import ../../db_backend
import ../../models/[user, customer]


export json
export strutils
export sugar
export options

export db_backend
export user
export customer


router customers:
  post "/":
    let age = if len(@"age") > 0: some parseInt(@"age").Natural else: none Natural

    var customer = newCustomer(newUser(@"email"), @"name", age)

    withDb:
      db.insert(customer)

    resp(Http201, $customer.id)

  get "/@id":
    var customer = newCustomer()

    try:
      withDb:
        db.select(customer, "Customer.id = ?", @"id")

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
      db.select(customers, "1 LIMIT ? OFFSET ?", limit, offset)

    resp(%* customers)

  delete "/@id":
    try:
      withDb:
        discard newCustomer().dup:
          db.select("Customer.id = ?", @"id")
          db.delete

      resp Http204

    except KeyError:
      resp Http404
