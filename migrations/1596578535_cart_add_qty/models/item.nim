import norm/model


type
  Item* = ref object of Model
    title*:string
    unitPrice*: float
    stock*: Natural


func newItem*(title: string, unitPrice: float, stock: Natural): Item =
  Item(title: title, unitPrice: unitPrice, stock: stock)

func newItem*(title: string, unitPrice: float): Item =
  newItem(title, unitPrice, 0)

func newItem*: Item =
  newItem("", 0.0, 0)
