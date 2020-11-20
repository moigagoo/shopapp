import strformat

include karax/prelude
import karax/vstyles

import ../../models/item


proc render*(item: Item): VNode =
  buildHtml:
    tdiv(style = {margin: "10px", borderColor: "red", borderStyle: "dashed"}):
      h3:
        text item.title

      p:
        text $item.unitPrice

      button:
        text &"Buy item #{item.id}"
        proc onClick =
          echo item[]
          echo &"Buy item #{item.id}"
