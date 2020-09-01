import norm/model

import item, purchase


type
  Subpurchase* = ref object of Model
    purchase*: Purchase
    item*: Item
    qty*: Positive
    unitPrice*: float


func newSubpurchase*(purchase: Purchase, item: Item, qty: Positive, unitPrice: float): Subpurchase =
  Subpurchase(purchase: purchase, item: item, qty: qty, unitPrice: unitPrice)

proc newSubpurchase*: Subpurchase =
  newSubpurchase(newPurchase(), newItem(), 1, 0.0)
