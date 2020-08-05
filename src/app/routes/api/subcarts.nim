import json
import strutils
import sugar

import jester

import ../../db_backend
import ../../models/[subcart, customer, item]


export json
export strutils
export sugar

export db_backend
export subcart
export customer
export item


router subcarts:
  post "/":
    let qty = if len(@"qty") > 0: parseInt(@"qty").Positive else: 1

    var
      customer = newCustomer()
      item = newItem()
      subcart = newSubcart(customer, item, qty)

    try:
      withDb:
        db.select(customer, """"Customer".id = $1""", parseInt(@"customerId"))
        db.select(item, """id = $1""", parseInt(@"itemId"))
        db.insert(subcart)

      resp(Http201, $subcart.id)

    except KeyError:
      resp Http404

    except:
      resp Http400

  get "/@id":
    var subcart = newSubcart()

    try:
      withDb:
        db.select(subcart, """"Subcart".id = $1""", parseInt(@"id"))

    except KeyError:
      resp Http404

    resp(%* subcart)

  get "/":
    let
      perPage = if len(@"per_page") > 0: parseInt(@"per_page") else: 10
      page = if len(@"page") > 0: parseInt(@"page") else: 1
      limit = if perPage > 0: perPage else: 10
      offset = if page > 0: limit * (page - 1) else: 0

    var subcarts = @[newSubcart()]

    withDb:
      db.select(subcarts, "TRUE LIMIT $1 OFFSET $2", limit, offset)

    resp(%* subcarts)

  put "/@id":
    var subcart = newSubcart()

    try:
      withDb:
        db.select(subcart, """"Subcart".id = $1""", parseInt(@"id"))

        if len(@"qty") > 0: subcart.qty = parseInt(@"qty").Positive

        db.update(subcart)

    except KeyError:
      resp Http404

    except:
      resp Http400

    resp Http200

  delete "/@id":
    try:
      withDb:
        discard newSubcart().dup:
          db.select(""""Subcart".id = $1""", parseInt(@"id"))
          db.delete

      resp Http204

    except KeyError:
      resp Http404
