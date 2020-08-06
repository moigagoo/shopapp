import jester

import api/[customers, items, subcarts, stocks]


export customers
export items
export subcarts
export stocks


router api:
  extend customers, "/customers"
  extend items, "/items"
  extend subcarts, "/subcarts"
  extend stocks, "/stocks"
