import jester

import dotenv

import app/routes/api


const indexHtml = """
<!DOCTYPE html>
<html>
<head>
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <title>index</title>

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
