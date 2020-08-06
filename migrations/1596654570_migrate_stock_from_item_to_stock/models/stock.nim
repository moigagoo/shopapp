import norm/model
import item


type
  Stock* = ref object of Model
    item*: Item
    qty*: Natural


func newStock*(item: Item, qty: Natural): Stock =
  Stock(item: item, qty: qty)

func newStock*(item: Item): Stock =
  newStock(item, 0)

func newStock*: Stock =
  newStock(newItem())
