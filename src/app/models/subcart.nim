import norm/model

import customer, item


type
  Subcart* = ref object of Model
    customer*: Customer
    item*: Item
    qty*: Natural


func newSubcart*(customer: Customer, item: Item, qty: Natural): Subcart =
  Subcart(customer: customer, item: item, qty: qty)

func newSubcart*(customer: Customer, item: Item): Subcart =
  newSubcart(customer, item, 1)

func newSubcart*: Subcart =
  newSubcart(newCustomer(), newItem())
