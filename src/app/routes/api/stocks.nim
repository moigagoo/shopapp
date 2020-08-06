import json
import strutils
import sugar

import jester

import ../../db_backend
import ../../models/[stock, item]


export json
export strutils
export sugar

export db_backend
export stock
export item


router stocks:
  post "/":
    let qty = if len(@"qty") > 0: parseInt(@"qty").Natural else: 0

    var
      item = newItem()
      stock = newStock(item, qty)

    try:
      withDb:
        db.select(item, """id = $1""", parseInt(@"itemId"))
        db.insert(stock)

      resp(Http201, $stock.id)

    except KeyError:
      resp Http404

    except:
      resp Http400

  get "/@id":
    var stock = newStock()

    try:
      withDb:
        db.select(stock, """"Stock".id = $1""", parseInt(@"id"))

    except KeyError:
      resp Http404

    resp(%* stock)

  get "/":
    let
      perPage = if len(@"per_page") > 0: parseInt(@"per_page") else: 10
      page = if len(@"page") > 0: parseInt(@"page") else: 1
      limit = if perPage > 0: perPage else: 10
      offset = if page > 0: limit * (page - 1) else: 0

    var stocks = @[newStock()]

    withDb:
      db.select(stocks, """TRUE LIMIT $1 OFFSET $2""", limit, offset)

    resp(%* stocks)

  put "/@id":
    var stock = newStock()

    try:
      withDb:
        db.select(stock, """"Stock".id = $1""", parseInt(@"id"))

        if len(@"qty") > 0: stock.qty = parseInt(@"qty").Natural

        db.update(stock)

    except KeyError:
      resp Http404

    resp Http200

  delete "/@id":
    try:
      withDb:
        discard newStock().dup:
          db.select(""""Stock".id = $1""", parseInt(@"id"))
          db.delete

      resp Http204

    except KeyError:
      resp Http404
