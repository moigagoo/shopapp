import times
import json
import options


func `%`*(dt: DateTime): JsonNode =
  %($dt)
