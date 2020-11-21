import strformat

include karax/prelude

import ../../models/item


proc renderItem*(item: Item, ctx: RouterData): VNode =
  buildHtml:
    aside:
      h3: text item.title
      details:
        summary: text "Great product"
        p:
          text "This is a really cool thing y'all."

      p:
        mark: text &"${item.unitPrice}"

      button: text &"Buy item #{item.id}"
