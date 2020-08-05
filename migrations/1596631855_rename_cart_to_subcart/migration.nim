include normanpkg/prelude

import app/db_backend


migrate:
  withDb:
    let qry = """ALTER TABLE "Cart" RENAME TO "Subcart""""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Subcart" RENAME TO "Cart""""

    debug qry
    db.exec sql qry
