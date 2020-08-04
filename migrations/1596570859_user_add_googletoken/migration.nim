include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "User" ADD COLUMN googleToken TEXT NOT NULL DEFAULT ''"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "User" DROP COLUMN googleToken"""

    debug qry
    db.exec sql qry
