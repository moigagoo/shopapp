import jester

import api/[customers, items]


export customers
export items


router api:
  extend customers, "/customers"
  extend items, "/items"
