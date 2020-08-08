include karax/prelude


proc renderCounter*(val, maxVal: int): VNode =
  buildHtml(tdiv):
    span(text $val & "/" & $maxVal)
