import times

import norm/model

import customer, item


type
  Subpurchase* = ref object of Model
    customer*: Customer
    item*: Item
    qty*: Positive
    unitPrice*: float
    ts*: DateTime


func newSubpurchase*(customer: Customer, item: Item, qty: Positive, unitPrice: float, ts: DateTime): Subpurchase =
  Subpurchase(customer: customer, item: item, qty: qty, unitPrice: unitPrice, ts: ts)

proc newSubpurchase*(customer: Customer, item: Item, qty: Positive, unitPrice: float): Subpurchase =
  newSubpurchase(customer, item, qty, unitPrice, now().utc())

proc newSubpurchase*: Subpurchase =
  newSubpurchase(newCustomer(), newItem(), 1, 0.0)
