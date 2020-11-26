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
      top: "0",
      right: if state.visible: "0" else: "-300px",
      position: "fixed",
      zIndex: "1",
      backgroundColor: "#FFF",
      boxShadow: "0 0 10px black",
      transition: "0.4s"
    }):
      ul:
        li: text "Hello"
        li: text "from"
        li: text "Sidebar"
