import json
import strutils
import sugar

import jester

import ../../db_backend
import ../../models/[cart, customer, item]


export json
export strutils
export sugar

export db_backend
export cart
export customer
export item


router carts:
  post "/":
    var
      customer = newCustomer()
      item = newItem()
      cart = newCart(customer, item)

    try:
      withDb:
        db.select(customer, """"Customer".id = $1""", parseInt(@"customerId"))
        db.select(item, """id = $1""", parseInt(@"itemId"))
        db.insert(cart)

      resp(Http201, $cart.id)

    except KeyError:
      resp Http404

    except DbError:
      resp Http409

  get "/@id":
    var cart = newCart()

    try:
      withDb:
        db.select(cart, """"Cart".id = $1""", parseInt(@"id"))

    except KeyError:
      resp Http404

    resp(%* cart)

  get "/":
    let
      perPage = if len(@"per_page") > 0: parseInt(@"per_page") else: 10
      page = if len(@"page") > 0: parseInt(@"page") else: 1
      limit = if perPage > 0: perPage else: 10
      offset = if page > 0: limit * (page - 1) else: 0

    var carts = @[newCart()]

    withDb:
      db.select(carts, "TRUE LIMIT $1 OFFSET $2", limit, offset)

    resp(%* carts)

  delete "/@id":
    try:
      withDb:
        discard newCart().dup:
          db.select(""""Cart".id = $1""", parseInt(@"id"))
          db.delete

      resp Http204

    except KeyError:
      resp Http404
