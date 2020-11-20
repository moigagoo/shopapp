import strutils

include karax/prelude

import pages/items


type
  GlobalState = ref object
    itemsPageState: ItemsPageState


proc newGlobalState: GlobalState =
  GlobalState(itemsPageState: newItemsPageState())


proc main =
  var state = newGlobalState()

  proc render(context: RouterData): VNode =
    buildHtml(tdiv):
      if context.hashPart.startsWith("#items"):
        if context.hashPart != "#items":
          let page = parseInt(context.hashPart.split("/")[^1])
          state.itemsPageState.page = page

        render state.itemsPageState

      else:
        p:
          text "Hello from Karax 😌"

        a(href="#items"):
          text "Go to Items"


  setRenderer render


when isMainModule:
  main()
