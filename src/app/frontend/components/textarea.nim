include karax/prelude


proc renderTextarea*(onKeyUpProc: EventHandler): VNode =
  buildHtml:
    textarea(onkeyup = onKeyUpProc)
