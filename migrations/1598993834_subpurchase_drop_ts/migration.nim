include normanpkg/prelude

import app/db_backend



migrate:
  withDb:
    db.transaction:
      let qry = """ALTER TABLE "Subpurchase" DROP COLUMN ts"""

      debug qry
      db.exec sql qry

undo:
  import "../1596981822_subpurchase_migrate_to_purchase/models/subpurchase"

  withDb:
    db.transaction:
      let qry = """ALTER TABLE "Subpurchase" ADD COLUMN ts TIMESTAMP WITH TIME ZONE NOT NULL"""

      debug qry
      db.exec sql qry

      var subpurchases = @[newSubpurchase()]

      db.select(subpurchases, """TRUE""")

      for subpurchase in subpurchases.mitems:
        subpurchase.ts = subpurchase.purchase.ts
        db.update(subpurchase)
