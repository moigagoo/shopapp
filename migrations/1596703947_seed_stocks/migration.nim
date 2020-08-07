include normanpkg/prelude

import app/db_backend

import models/[stock, item]


migrate:
  withDb:
    db.transaction:
      for i in 1..9:
        var
          item = newItem()
          stock = newStock(item, i)

        db.select(item, """id = $1""", i)
        db.insert(stock)

undo:
  withDb:
    db.transaction:
      discard @[newStock()].dup:
        db.select("""TRUE""")
        db.delete
