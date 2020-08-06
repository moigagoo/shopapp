include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "Stock" ADD UNIQUE (item)"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Stock" DROP CONSTRAINT "Stock_item_key""""

    debug qry
    db.exec sql qry
