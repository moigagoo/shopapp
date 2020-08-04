include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "Cart" ADD UNIQUE (customer, item)"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Cart" DROP CONSTRAINT "Cart_customer_item_key""""

    debug qry
    db.exec sql qry
