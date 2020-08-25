import times

import norm/model

import customer


type
  Purchase* = ref object of Model
    customer*: Customer
    ts*: DateTime


func newPurchase*(customer: Customer, ts: DateTime): Purchase =
  Purchase(customer: customer, ts: ts)

proc newPurchase*(customer: Customer): Purchase =
  newPurchase(customer, now().utc())

proc newPurchase*: Purchase =
  newPurchase(newCustomer())
