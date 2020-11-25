include karax/prelude
import karax/vstyles


var visible: bool = true


proc renderSidebar*(ctx: RouterData): VNode =
  buildHtml:
    tdiv(style = {
      height: "100%",
      width: "300px",
      position: "fixed",
      top: "0",
      right: "0",
      zIndex: "1",
      boxShadow: "0 0 10px black",
      backgroundColor: "#FFF",
      visibility: if visible: "visible" else: "hidden"
    }):
      button:
        text ">>"
        proc onClick = visible = not visible

      ul:
        li: text "Hello"
        li: text "from"
        li: text "Sidebar"
