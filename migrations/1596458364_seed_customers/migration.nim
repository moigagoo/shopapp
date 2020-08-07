import strutils
import sugar

include normanpkg/prelude

import app/db_backend

import models/[user, customer]


migrate:
  withDb:
    db.transaction:
      for i in 1..10:
        discard newCustomer(newUser("user$#@example.com" % $i), "Alice $#" % $i, 20 + i).dup:
          db.insert

undo:
  withDb:
    db.transaction:
      discard @[newCustomer()].dup:
        db.select("""TRUE""")
        db.delete
