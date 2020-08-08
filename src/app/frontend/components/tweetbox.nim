import sugar

include karax/prelude

import textarea, counter, button


type
  TweetBox* = object
    tweetText: kstring

func initTweetBox*(): TweetBox =
  result.tweetText = ""


const maxTweetLength = 10


proc render*(tweetBox: var TweetBox): VNode =
  buildHtml(tdiv):
    renderTextarea(onKeyUpProc = (event: Event, node: VNode) => (tweetBox.tweetText = node.value))

    renderCounter(tweetBox.tweetText.len, maxTweetLength)

    renderButton(
      caption = "Submit",
      disabled = tweetBox.tweetText.len notin 1..maxTweetLength,
      onClickProc = () => (echo "Send tweet: " & tweetBox.tweetText)
    )
