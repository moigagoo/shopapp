include normanpkg/prelude

import sugar

import app/db_backend

import "../1596654570_migrate_stock_from_item_to_stock/models/item"
import "../1596654570_migrate_stock_from_item_to_stock/models/stock"


migrate:
  withDb:
    let qry = """ALTER TABLE "Item" DROP COLUMN stock"""

    debug qry
    db.exec sql qry

undo:
  withDb:
    let qry = """ALTER TABLE "Item" ADD COLUMN stock INTEGER NOT NULL DEFAULT 0"""

    debug qry
    db.exec sql qry

    let stocks = @[newStock()].dup:
      db.select("""TRUE""")

    for stock in stocks:
      var item = newItem()

      db.select(item, """id = $1""", stock.item.id)

      item.stock = stock.qty

      db.update(item)
