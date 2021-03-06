import karax/[karaxdsl, vdom, vstyles]


proc renderLoader*: VNode =
  buildHtml:
    tdiv(style = {animation: "slide-up 0.4s ease"}):
      tdiv(style = {
        margin: "auto",
        marginTop: "20%",
        border: "16px solid #f3f3f3",
        borderRadius: "50%",
        borderTop: "16px solid #3498db",
        width: "120px",
        height: "120px",
        animation: "spin 2s linear infinite"
      })
