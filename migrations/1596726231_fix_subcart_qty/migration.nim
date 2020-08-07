include normanpkg/prelude

import sugar
import sequtils

import app/db_backend

import models/[subcart, stock]


migrate:
  withDb:
    db.transaction:
      proc fixQty(subcart: var Subcart) =
        let stock = newStock().dup:
          db.select(""""Stock".item = $1""", subcart.item.id)

        if subcart.qty > stock.qty:
          subcart.qty = stock.qty

      discard @[newSubcart()].dup:
        db.select("""TRUE""")
        apply(fixQty)
        db.update

undo:
  withDb:
    discard
