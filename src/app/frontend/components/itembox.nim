import strformat

import karax/[karax, karaxdsl, vdom]

import ../../models/item


proc renderItem*(item: Item, ctx: RouterData): VNode =
  buildHtml(tdiv):
    aside:
      h3: text item.title

      figure:
        img(src = "https://avatars0.githubusercontent.com/u/1045340?s=460&v=4")

      details:
        summary: text "Great product"
        p:
          text "This is a really cool thing y'all."

      p:
        mark: text &"${item.unitPrice}"

      a(href = &"#items/{item.id}"):
        em: text &"View item"
