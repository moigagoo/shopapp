include normanpkg/prelude

import app/db_backend

import models/[stock, item]


migrate:
  withDb:
    for i in 1..9:
      var
        item = newItem()
        stock = newStock(item, i)

      db.select(item, """id = $1""", i)

      db.insert(stock)

undo:
  withDb:
    discard @[newStock()].dup:
      db.select("""TRUE""")
      db.delete
