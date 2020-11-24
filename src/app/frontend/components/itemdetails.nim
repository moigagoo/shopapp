import strformat

import karax/[karax, karaxdsl, vdom, vstyles]

import ../../models/item


proc renderItem*(item: Item, ctx: RouterData): VNode =
  buildHtml:
    tdiv(style = {animation: "slide-up 0.4s ease"}):
      h1: text item.title

      figure:
        img(src = "https://avatars0.githubusercontent.com/u/1045340?s=460&v=4")

      article:
        h2: text "Great product"

        aside:
          p:
            text "This is a really cool thing y'all."

        button:
          text &"${item.unitPrice}"
