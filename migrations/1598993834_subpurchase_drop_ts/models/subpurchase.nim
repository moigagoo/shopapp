import norm/model

import customer, item, purchase


type
  Subpurchase* = ref object of Model
    purchase*: Purchase
    customer*: Customer
    item*: Item
    qty*: Positive
    unitPrice*: float


func newSubpurchase*(purchase: Purchase, customer: Customer, item: Item, qty: Positive, unitPrice: float): Subpurchase =
  Subpurchase(purchase: purchase, customer: customer, item: item, qty: qty, unitPrice: unitPrice)

proc newSubpurchase*: Subpurchase =
  newSubpurchase(newPurchase(), newCustomer(), newItem(), 1, 0.0)
