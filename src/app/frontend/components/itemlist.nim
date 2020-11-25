import json, strformat

import karax/[kbase, karax, karaxdsl, vdom, kajax, vstyles]

import ../../models/item

import itembox, loader


const
  defaultPageNum = 1
  defaultPerPage = 3


type
  ItemList* = ref object
    page*, perPage*: Positive
    items*: seq[Item]
    allFetched*: bool


proc newItemList*: ItemList =
  result = ItemList(page: defaultPageNum, perPage: defaultPerPage, items: @[], allFetched: false)

proc updateItems*(state: var ItemList) =
  proc cb(stat: int, resp: kstring) =
    var items: seq[Item]

    if stat == 200:
      let payload = parseJson($resp)
      items = payload.to(seq[Item])

    if len(items) == 0:
      state.allFetched = true
    else:
      state.items.add items

  ajaxGet(&"/api/items/?page={state.page}&per_page={state.perPage}", @[], cb)


proc render*(state: var ItemList, ctx: RouterData): VNode =
  if not state.allFetched and len(state.items) < state.page * state.perPage:
    state.updateItems()

  buildHtml(tdiv):
    if len(state.items) == 0:
      renderLoader()
    else:
      section(style = {display: "flex", flexWrap: "wrap"}):
        for item in state.items:
          renderItem(item, ctx)

      if not state.allFetched:
        button:
          text "Load more"
          proc onClick = inc state.page
      else:
        small: text "All items loaded"
