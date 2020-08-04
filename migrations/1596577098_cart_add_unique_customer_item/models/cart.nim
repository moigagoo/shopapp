import norm/model

import customer, item


type
  Cart* = ref object of Model
    customer*: Customer
    item*: Item


func newCart*(customer: Customer, item: Item): Cart =
  Cart(customer: customer, item: item)

func newCart*: Cart =
  newCart(newCustomer(), newItem())
