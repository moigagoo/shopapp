include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "Cart" ADD COLUMN qty INTEGER NOT NULL DEFAULT 1"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Cart" DROP COLUMN qty"""

    debug qry
    db.exec sql qry
