import strutils
import sugar

include normanpkg/prelude

import app/db_backend
import app/models/[user, customer]


migrate:
  withDb:
    for i in 1..10:
      discard newCustomer(newUser("user$#@example.com" % $i), "Alice $#" % $i, 20 + i).dup:
        db.insert

undo:
  withDb:
    discard @[newCustomer()].dup:
      db.select("1")
      db.delete

