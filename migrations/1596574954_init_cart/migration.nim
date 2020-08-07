include normanpkg/prelude

import app/db_backend

import models/cart


migrate:
  withDb:
    db.transaction:
      db.createTables(newCart())

undo:
  let qry = """DROP TABLE IF EXISTS "Cart""""

  withDb:
    debug qry
    db.exec sql qry
