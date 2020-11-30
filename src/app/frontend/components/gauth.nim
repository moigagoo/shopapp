import jsffi, jsconsole, asyncjs

import karax/[kbase, karax, karaxdsl, vdom]


const clientId: kstring = "57979449313-sakjh4lfhc85q0otlo9ic7b0b0iv7cse.apps.googleusercontent.com"


var gapi {.importc.}: JsObject


type
  GAuth* = ref object
    loaded*, signedIn*: bool
    user*: JsObject


func newGAuth*(loaded, signedIn: bool, user: JsObject): GAuth =
  GAuth(loaded: loaded, signedIn: signedIn, user: user)

func newGAuth*: GAuth =
  newGAuth(false, false, nil)

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

proc signIn(state: var GAuth, clientCfg: JsObject) {.async.} =
  let
    user = await doSignIn(clientCfg)
    profile = user.getBasicProfile()
    authResp = user.getAuthResponse()

  console.log(profile.getGivenName())
  console.log(authResp.id_token)

  state.user = user
  state.signedIn = true

proc doSignOut(user: JsObject): Future[JsObject] {.async.} =
  newPromise(proc(resolve: proc(resp: JsObject)) =
    resolve user.signOut()
  )

proc signOut(state: var GAuth) {.async.} =
  discard await doSignOut(state.user)

  state.user = nil
  state.signedIn = false

proc render*(state: var GAuth, ctx: RouterData): VNode =
  if not state.loaded:
    loadScript("https://apis.google.com/js/platform.js?onload=init")
    state.loaded = true

  buildHtml:
    button:
      if not state.signedIn:
        text "Sign in with Google"
        proc onClick =
          discard state.signIn(JsObject{client_id: clientId})

      else:
        text "Sign out"
        proc onClick =
          discard state.signOut()

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
