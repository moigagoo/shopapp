include normanpkg/prelude

import sugar

import app/db_backend

import models/[item, stock]


migrate:
  withDb:
    db.transaction:
      let items = @[newItem()].dup:
        db.select("""TRUE""")

      for item in items:
        discard newStock(item, item.stock).dup:
          db.insert

undo:
  withDb:
    let qry = """DELETE FROM "Stock" WHERE TRUE"""

    debug qry
    db.exec sql qry
