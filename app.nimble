# Package

version       = "0.1.0"
author        = "Constantine Molchanov"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["app"]



# Dependencies

requires "nim >= 1.2.6", "dotenv >= 1.1.1", "jester#head", "norm >= 2.1.1", "norman >= 2.1.6"


# Tasks

task frontend, "Build frontend":
  exec "nim js -o:public/index.js src/app/frontend/index.nim"
