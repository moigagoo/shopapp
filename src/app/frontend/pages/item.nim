import json, strutils, strformat

include karax/prelude
import karax/kajax

import ../components/[itemdetails, loader]

import ../../models/item


type
  ItemPage* = ref object
    itemId*: Natural
    item*: Item


func newItemPage*(itemId: Natural, item: Item): ItemPage =
  ItemPage(itemId: itemId, item: item)

func newItemPage*: ItemPage =
  newItemPage(0, nil)


proc fetchItem*(state: var ItemPage) =
  proc cb(stat: int, resp: kstring) =
    if stat == 200:
      let payload = parseJson($resp)
      state.item = payload.to(Item)

  ajaxGet(&"/api/items/{state.itemId}", @[], cb)


proc render*(state: var ItemPage, ctx: RouterData): VNode =
  state.itemId = parseInt(ctx.hashPart.split("/")[^1])

  if state.item.isNil or state.item.id != state.itemId:
    state.fetchItem()

  buildHtml(tdiv):
    if state.item.isNil:
      renderLoader()
    else:
      renderItem(state.item, ctx)
