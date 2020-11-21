import json, strformat, strutils

include karax/prelude
import karax/[kajax, vstyles]

import ../../models/item

import itembox


const
  defaultPage = 1
  defaultPerPage = 3


type
  ItemList* = ref object
    page*, perPage*: Positive
    items*: seq[Item]


proc updateItems*(state: var ItemList) =
  proc cb(stat: int, resp: kstring) =
    if stat == 200:
      let
        payload = parseJson($resp)
        items = payload.to(seq[Item])

      state.items.add items

  ajaxGet(&"/api/items/?page={state.page}&per_page={state.perPage}", @[], cb)

proc newItemList*: ItemList =
  result = ItemList(page: defaultPage, perPage: defaultPerPage, items: @[])
  result.updateItems()


proc render*(state: var ItemList, ctx: RouterData): VNode =
  buildHtml(tdiv):
    section(style = {display: "flex", flexWrap: "wrap"}):
      for item in state.items:
        renderItem(item, ctx)

    button:
      text "Load more"
      proc onClick =
        inc state.page
        state.updateItems()
