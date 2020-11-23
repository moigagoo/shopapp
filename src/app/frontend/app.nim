import pegs

import karax/[karax, karaxdsl, vdom]

import pages/[items, item]
import components/loader


type
  State = ref object
    itemsPage: ItemsPage
    itemPage: ItemPage


proc newState: State =
  State(itemsPage: newItemsPage(), itemPage: newItemPage())


proc run =
  var state = newState()

  proc render(ctx: RouterData): VNode =
    buildHtml(tdiv):
      nav:
        ul:
          li: a(href = ""): text "🏠"
          li: a(href = "#items"): text "Items"

      main:
        if ctx.hashPart == ("#items"):
          state.itemsPage.render(ctx)
        elif $ctx.hashPart =~ peg"'#items/' \d+":
          state.itemPage.render(ctx)
        else:
          renderLoader()

  setRenderer render


when isMainModule:
  run()
