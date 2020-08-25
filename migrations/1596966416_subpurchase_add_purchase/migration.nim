include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    db.transaction:
      let qry = """ALTER TABLE "Subpurchase" ADD COLUMN purchase INTEGER NOT NULL"""

      debug qry
      db.exec sql qry

undo:
  withDb:
    db.transaction:
      let qry = """ALTER TABLE "Subpurchase" DROP COLUMN purchase"""

      debug qry
      db.exec sql qry
