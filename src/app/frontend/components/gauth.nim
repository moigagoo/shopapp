import jsffi, jsconsole, asyncjs

import karax/[kbase, karax, karaxdsl, vdom]


const clientId: kstring = "57979449313-sakjh4lfhc85q0otlo9ic7b0b0iv7cse.apps.googleusercontent.com"


var gapi {.importc.}: JsObject


proc init {.exportc.} =
  gapi.load("auth2")

proc getUser(clientCfg: JsObject): Future[JsObject] {.async.} =
  newPromise(proc(resolve: proc(resp: JsObject)) =
    resolve gapi.auth2.init(clientCfg)
  )

proc doSignIn(clientCfg: JsObject): Future[JsObject] {.async.} =
  var user = await getUser(clientCfg)

  newPromise(proc(resolve: proc(resp: JsObject)) =
    resolve user.signIn()
  )

proc signIn(clientCfg: JsObject) {.async.} =
  let
    user = await doSignIn(clientCfg)
    profile = user.getBasicProfile()
    authResp = user.getAuthResponse()

  console.log(profile.getGivenName())
  console.log(authResp.id_token)

proc renderGoogleButton*: VNode =
  loadScript("https://apis.google.com/js/platform.js?onload=init")

  buildHtml:
    button:
      text "Sign in with Google"
      proc onClick =
        discard signIn(JsObject{client_id: clientId})

        # gapi.auth2.init(clientCfg).then(
        #   proc(user: JsObject) = user.signIn().then(
        #     proc(user: JsObject) =
        #       let
        #         profile = user.getBasicProfile()
        #         authResp = user.getAuthResponse()

        #       console.log(profile.getGivenName())
        #       console.log(authResp.id_token)
        #   )
        # )
