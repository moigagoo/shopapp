include karax/prelude

import json

import karax/kajax

import components/tweetbox
import ../models/item


type
  State = object
    tweetBox: TweetBox
    anotherTweetBox: TweetBox

func initState(): State =
  result.tweetBox = initTweetBox()
  result.anotherTweetBox = initTweetBox()

var s: kstring

proc cb(httpStat: int, resp: kstring) =
  let
    j = parseJson($resp)
    i = j.to Item

  s = i.title

proc main() =
  var state = initState()

  proc render(): VNode =
    buildHtml(tdiv):
      h1(text "Hello Karax")

      render state.tweetBox
      render state.anotherTweetBox

      p:
        text s

      button:
        text "AJAX"
        proc onclick(ev: Event; n: VNode) =
          ajaxGet("/api/items/5", @[], cb)

  setRenderer render


when isMainModule:
  main()
