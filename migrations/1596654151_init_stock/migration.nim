include normanpkg/prelude

import app/db_backend

import models/stock


migrate:
  withDb:
    db.transaction:
      db.createTables(newStock())

undo:
  let qry = """DROP TABLE IF EXISTS "Stock""""

  withDb:
    debug qry
    db.exec sql qry
