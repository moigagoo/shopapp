include karax/prelude

import ../components/itemlist


type
  ItemsPage* = ref object
    itemList*: ItemList


proc newItemsPage*: ItemsPage =
  ItemsPage(itemList: newItemList())


proc render*(state: ItemsPage, ctx: RouterData): VNode =
  buildHtml(tdiv):
    h1: text "Items"
    state.itemList.render(ctx)
