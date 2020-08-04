include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "Item" ADD COLUMN stock INTEGER NOT NULL DEFAULT 0"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Item" DROP COLUMN stock"""

    debug qry
    db.exec sql qry
