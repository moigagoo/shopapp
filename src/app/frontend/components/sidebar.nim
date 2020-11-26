import karax/[karax, karaxdsl, vdom, vstyles]


type
  SideBar* = ref object
    visible*: bool


func newSideBar*(visible: bool): SideBar =
  SideBar(visible: visible)

func newSideBar*: SideBar =
  newSideBar(false)


proc render*(state: SideBar, ctx: RouterData): VNode =
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
      visibility: if state.visible: "visible" else: "hidden"
    }):
      ul:
        li: text "Hello"
        li: text "from"
        li: text "Sidebar"
