include normanpkg/prelude

import sugar

import app/db_backend

import models/[subcart, customer, item]


migrate:
  withDb:
    db.transaction:
      for i in 1..9:
        var customer = newCustomer()

        db.select(customer, """"Customer".id = $1""", i)

        for j in 1..i:
          let item = newItem().dup:
            db.select("""id = $1""", j)

          discard newSubcart(customer, item, i).dup:
            db.insert

undo:
  withDb:
    db.transaction:
      discard @[newSubcart()].dup:
        db.select("""TRUE""")
        db.delete
