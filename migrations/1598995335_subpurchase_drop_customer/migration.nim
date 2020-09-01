include normanpkg/prelude

import app/db_backend



migrate:
  withDb:
    db.transaction:
      let qrs = [
        """ALTER TABLE "Subpurchase" DROP CONSTRAINT "Subpurchase_customer_fkey"""",
        """ALTER TABLE "Subpurchase" DROP COLUMN customer"""
      ]

      for qry in qrs:
        debug qry
        db.exec sql qry

undo:
  import "../1598993834_subpurchase_drop_ts/models/subpurchase"

  withDb:
    db.transaction:
      let qrs = [
        """ALTER TABLE "Subpurchase" ADD COLUMN customer INTEGER NOT NULL""",
        """ALTER TABLE "Subpurchase" ADD CONSTRAINT "Subpurchase_customer_fkey" FOREIGN KEY(customer) REFERENCES "Customer"(id)"""
      ]

      for qry in qrs:
        debug qry
        db.exec sql qry

      var subpurchases = @[newSubpurchase()]

      db.select(subpurchases, """TRUE""")

      for subpurchase in subpurchases.mitems:
        subpurchase.customer = subpurchase.purchase.customer
        db.update(subpurchase)
