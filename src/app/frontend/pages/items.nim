include karax/prelude

import ../components/itemlist


const defaultPage = 1


type
  ItemsPageState* = ref object
    itemList*: ItemList


proc newItemsPageState*: ItemsPageState =
  ItemsPageState(itemList: newItemList(defaultPage))

proc `page=`*(state: var ItemsPageState, val: Positive) =
  state.itemList.page = val
  state.itemList.updateItems()


proc render*(state: ItemsPageState): VNode =
  buildHtml(tdiv):
    h1:
      text "This is the item list"

    render state.itemlist
