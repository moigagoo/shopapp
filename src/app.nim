import jester

import dotenv

import app/routes/api


const indexHtml = """
<!DOCTYPE html>
<html>
  <head>
    <title>Shop</title>

    <meta content="width=device-width, initial-scale=1" name="viewport" />

    <link rel="stylesheet" href="https://unpkg.com/mvp.css">
    <link rel="stylesheet" href="animations.css">
  </head>

  <body id="body">
    <div id="ROOT" />
    <script type="text/javascript" src="app.js"></script>
  </body>
</html>
"""


initDotEnv().load()


routes:
  get "/":
    resp indexHtml

  extend api, "/api"
