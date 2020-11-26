import pegs

import karax/[karax, karaxdsl, vdom]

import pages/[items, item]
import components/[loader, sidebar]


type
  State = ref object
    itemsPage: ItemsPage
    itemPage: ItemPage
    sideBar: SideBar


proc newState: State =
  State(itemsPage: newItemsPage(), itemPage: newItemPage(), sideBar: newSideBar())


proc run =
  var state = newState()

  proc render(ctx: RouterData): VNode =
    buildHtml(tdiv):
      nav:
        ul:
          li: a(href = ""): text "🏠"
          li: a(href = "#items"): text "Items"
          li:
            button:
              text "🍔"
              proc onClick = state.sideBar.visible = not state.sideBar.visible

      state.sideBar.render(ctx)

      main:
        if ctx.hashPart == ("#items"):
          state.itemsPage.render(ctx)
        elif $ctx.hashPart =~ peg" '#items/' \d+ ":
          state.itemPage.render(ctx)
        else:
          renderLoader()

  setRenderer render


when isMainModule:
  run()
