include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "Subcart" ADD COLUMN purchasedAt TIMESTAMP WITH TIME ZONE"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Subcart" DROP COLUMN purchasedAt"""

    debug qry
    db.exec sql qry
