import options

import norm/model

import user


type
  Customer* = ref object of Model
    auth*: User
    name*: string
    age*: Option[Natural]


func newCustomer*(auth: User, name: string, age: Option[Natural]): Customer =
  Customer(auth: auth, name: name, age: age)

func newCustomer*(auth: User, name: string, age: Natural): Customer =
  newCustomer(auth, name, some age)

func newCustomer*(auth: User, name: string): Customer =
  newCustomer(auth, name, none Natural)

func newCustomer*: Customer =
  newCustomer(newUser(), "")
