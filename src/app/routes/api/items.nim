import json
import strutils
import sugar

import jester

import ../../db_backend
import ../../models/item


export json
export strutils
export sugar

export db_backend
export item


router items:
  post "/":
    var item = newItem(@"title", parseFloat(@"price"))

    withDb:
      db.insert(item)

    resp(Http201, $item.id)

  get "/@id":
    var item = newItem()

    try:
      withDb:
        db.select(item, """id = $1""", parseInt(@"id"))

    except KeyError:
      resp Http404

    resp(%* item)

  get "/":
    let
      perPage = if len(@"per_page") > 0: parseInt(@"per_page") else: 10
      page = if len(@"page") > 0: parseInt(@"page") else: 1
      limit = if perPage > 0: perPage else: 10
      offset = if page > 0: limit * (page - 1) else: 0

    var items = @[newItem()]

    withDb:
      db.select(items, """TRUE LIMIT $1 OFFSET $2""", limit, offset)

    resp(%* items)

  put "/@id":
    var item = newItem()

    try:
      withDb:
        db.select(item, """id = $1""", parseInt(@"id"))

        if len(@"title") > 0: item.title = @"title"
        if len(@"price") > 0: item.unitPrice = parseFloat(@"price")

        db.update(item)

    except KeyError:
      resp Http404

    resp Http200

  delete "/@id":
    try:
      withDb:
        discard newItem().dup:
          db.select("""id = $1""", parseInt(@"id"))
          db.delete

      resp Http204

    except KeyError:
      resp Http404
