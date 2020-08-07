include normanpkg/prelude

import strutils
import lenientops
import sugar

import app/db_backend

import models/item


migrate:
  withDb:
    db.transaction:
      for i in 1..9:
        discard newItem("Golden Pants #$#" % $i, i * 1.11).dup:
          db.insert

undo:
  withDb:
    db.transaction:
      discard @[newItem()].dup:
        db.select("""TRUE""")
        db.delete
