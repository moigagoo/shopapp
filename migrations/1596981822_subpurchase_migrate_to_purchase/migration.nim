include normanpkg/prelude

import sugar

import app/db_backend

import models/[subpurchase, purchase]


migrate:
  withDb:
    db.transaction:
      var subpurchases = @[newSubpurchase()]

      db.select(subpurchases, """TRUE""")

      for subpurchase in subpurchases.mitems:
        subpurchase.purchase = newPurchase(subpurchase.customer, subpurchase.ts).dup:
          db.insert

        db.update(subpurchase)

undo:
  withDb:
    db.transaction:
      discard @[newPurchase()].dup:
        db.select("""TRUE""")
        db.delete
