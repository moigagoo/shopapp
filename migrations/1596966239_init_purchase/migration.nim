include normanpkg/prelude

import app/db_backend
import models/purchase


migrate:
  withDb:
    db.transaction:
      db.createTables(newPurchase())

undo:
  withDb:
    let qry = """DROP TABLE IF EXISTS "Purchase""""

    debug qry
    db.exec sql qry
