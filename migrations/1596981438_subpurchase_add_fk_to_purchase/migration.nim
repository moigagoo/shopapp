include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    db.transaction:
      let qry = """ALTER TABLE "Subpurchase" ADD CONSTRAINT purchase_fkey FOREIGN KEY(purchase) REFERENCES "Purchase"(id)"""

      debug qry
      db.exec sql qry

undo:
  withDb:
    db.transaction:
      let qry = """ALTER TABLE "Subpurchase" DROP CONSTRAINT purchase_fkey"""

      debug qry
      db.exec sql qry
