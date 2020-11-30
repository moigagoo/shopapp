import jsffi, jsconsole, asyncjs

import karax/[kbase, karax, karaxdsl, vdom]


const clientId: kstring = "57979449313-sakjh4lfhc85q0otlo9ic7b0b0iv7cse.apps.googleusercontent.com"

var gapi {.importc.}: JsObject


proc init {.exportc.} =
  gapi.load("auth2")


proc renderGoogleButton*: VNode =
  loadScript("https://apis.google.com/js/platform.js?onload=init")

  buildHtml:
    button:
      text "Sign in with Google"
      proc onClick =
        let clientCfg = JsObject{client_id: clientId}

        gapi.auth2.init(clientCfg).then(
          proc(user: JsObject) = user.signIn().then(
            proc(user: JsObject) =
              let profile = user.getBasicProfile()
              console.log(profile)
          )
        )
