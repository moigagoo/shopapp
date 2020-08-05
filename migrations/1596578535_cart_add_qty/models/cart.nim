import norm/model

import customer, item


type
  Cart* = ref object of Model
    customer*: Customer
    item*: Item
    qty*: Positive


func newCart*(customer: Customer, item: Item, qty: Positive): Cart =
  Cart(customer: customer, item: item, qty: qty)

func newCart*(customer: Customer, item: Item): Cart =
  newCart(customer, item, 1)

func newCart*: Cart =
  newCart(newCustomer(), newItem())
