import norm/model


type
  Item* = ref object of Model
    title*:string
    unitPrice*: float


func newItem*(title: string, unitPrice: float): Item =
  Item(title: title, unitPrice: unitPrice)

func newItem*: Item =
  newItem("", 0.0)
