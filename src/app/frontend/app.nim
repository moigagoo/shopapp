import strutils

include karax/prelude

import pages/items


type
  State = ref object
    itemsPage: ItemsPage


proc newState: State =
  State(itemsPage: newItemsPage())


proc run =
  var state = newState()

  proc render(ctx: RouterData): VNode =
    buildHtml(tdiv):
      nav:
        ul:
          li: a(href = ""): text "🏠"
          li: a(href = "#items"): text "Items"

      main:
        if ctx.hashPart.startsWith("#items"):
          state.itemsPage.render(ctx)
        else:
          p: text "🔥"

  setRenderer render


when isMainModule:
  run()
