import json, strformat, strutils

include karax/prelude
import karax/kajax

import ../../models/item

import itembox


const defaultPerPage = 3


type
  ItemList* = ref object
    page*, perPage*: Positive
    items*: seq[Item]


proc updateItems*(itemList: var ItemList) =
  proc cb(stat: int, resp: kstring) =
    if stat == 200:
      let
        payload = parseJson($resp)
        items = payload.to(seq[Item])

      itemList.items = items

  ajaxGet(&"/api/items/?page={itemList.page}&per_page={itemList.perPage}", @[], cb)

proc newItemList*(page, perPage: Positive, items: seq[Item]): ItemList =
  result = ItemList(page: page, perPage: perPage, items: items)
  result.updateItems()

proc newItemList*(page: Positive): ItemList =
  newItemList(page, defaultPerPage, @[])


proc render*(itemList: ItemList): VNode =
  buildHtml(tdiv):
    h1:
      text &"Page: {itemList.page}"

    select:
      option: text "1"
      option(selected = ""): text "3"
      option: text "5"
      proc onChange(ev: Event, n: VNode) =
        itemList.perPage = parseInt(n.value)

    if itemList.page > 1:
      a(href = &"#items/{itemList.page - 1}"):
        text "<<"

    a(href = &"#items/{itemList.page + 1}"):
      text ">>"

    for item in itemList.items:
      render item
