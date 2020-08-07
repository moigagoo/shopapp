include normanpkg/prelude

import app/db_backend

import models/item


migrate:
  withDb:
    db.transaction:
      db.createTables(newItem())

undo:
  let qry = """DROP TABLE IF EXISTS "Item""""

  withDb:
    debug qry
    db.exec sql qry
