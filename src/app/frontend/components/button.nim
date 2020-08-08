import sugar

include karax/prelude


proc renderButton*(caption: string, disabled: bool, onClickProc: () -> void): VNode =
  buildHtml:
    button(disabled = toDisabled(disabled), onclick = onClickProc):
      text caption
