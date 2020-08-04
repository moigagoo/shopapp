import jester

import api/[customers, items, carts]


export carts
export customers
export items


router api:
  extend customers, "/customers"
  extend items, "/items"
  extend carts, "/carts"
