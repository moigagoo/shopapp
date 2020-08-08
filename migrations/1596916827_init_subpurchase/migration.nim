include normanpkg/prelude

import app/db_backend
import models/subpurchase


migrate:
  withDb:
    db.transaction:
      db.createTables(newSubpurchase())

undo:
  withDb:
    let qry = """DROP TABLE IF EXISTS "Subpurchase""""

    debug qry
    db.exec sql qry
