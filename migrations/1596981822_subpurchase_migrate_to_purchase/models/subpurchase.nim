import times

import norm/model

import customer, item, purchase


type
  Subpurchase* = ref object of Model
    purchase*: Purchase
    customer*: Customer
    item*: Item
    qty*: Positive
    unitPrice*: float
    ts*: DateTime


func newSubpurchase*(purchase: Purchase, customer: Customer, item: Item, qty: Positive, unitPrice: float, ts: DateTime): Subpurchase =
  Subpurchase(purchase: purchase, customer: customer, item: item, qty: qty, unitPrice: unitPrice, ts: ts)

proc newSubpurchase*(purchase: Purchase, customer: Customer, item: Item, qty: Positive, unitPrice: float): Subpurchase =
  newSubpurchase(purchase, customer, item, qty, unitPrice, now().utc())

proc newSubpurchase*: Subpurchase =
  newSubpurchase(newPurchase(), newCustomer(), newItem(), 1, 0.0)
