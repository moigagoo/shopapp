import jsffi, jsconsole, asyncjs

import karax/[kbase, karax, karaxdsl, vdom]


const clientId: kstring = "57979449313-sakjh4lfhc85q0otlo9ic7b0b0iv7cse.apps.googleusercontent.com"


var gapi {.importc.}: JsObject


type
  GoogleButton* = ref object
    signedIn*: bool

func newGoogleButton*(signedIn: bool): GoogleButton =
  GoogleButton(signedIn: signedIn)

func newGoogleButton*: GoogleButton =
  newGoogleButton(false)


proc init {.exportc.} =
  gapi.load("auth2")

# proc getUser(clientCfg: JsObject): Future[JsObject] {.async.} =
#   newPromise(proc(resolve: proc(resp: JsObject)) =
#     resolve gapi.auth2.init(clientCfg)
#   )

# proc doSignIn(clientCfg: JsObject): Future[JsObject] {.async.} =
#   var user = await getUser(clientCfg)

#   newPromise(proc(resolve: proc(resp: JsObject)) =
#     resolve user.signIn()
#   )

# proc signIn(clientCfg: JsObject) {.async.} =
#   let
#     user = await doSignIn(clientCfg)
#     profile = user.getBasicProfile()
#     authResp = user.getAuthResponse()

#   console.log(profile.getGivenName())
#   console.log(authResp.id_token)

proc render*(state: var GoogleButton, ctx: RouterData): VNode =
  loadScript("https://apis.google.com/js/platform.js?onload=init")

  buildHtml:
    button:
      if not state.signedIn:
        text "Sign in with Google"
        proc onClick =
          gapi.auth2.init(JsObject{client_id: clientId}).then(
            proc(user: JsObject) = user.signIn().then(
              proc(user: JsObject) =
                let
                  profile = user.getBasicProfile()
                  authResp = user.getAuthResponse()

                console.log(profile.getGivenName())
                console.log(authResp.id_token)

                state.signedIn = true
                redraw()
            )
          )
        # discard signIn(JsObject{client_id: clientId})

      else:
        text "Sign out"
        proc onClick =
          let auth2 = gapi.auth2.getAuthInstance()
          auth2.signOut().then(proc = state.signedIn = false)
