module About (view) where

import CommonStyles

import Html exposing (div, p, img, text)
import Html.Attributes exposing (..)

view : Html.Html
view =
  div []
    [
      p [] [text tagLine]
    , p [] [text "Here's a picture of me walking around Pittsburgh"]
    , img [src imageSource, imageStyle] []
    ]

tagLine : String
tagLine = "My name is Michael Gilliland. I'm a software engineer who enjoys functional programming, testing, collaboratively building software and problem solving."

imageSource : String
imageSource = "https://github.com/mjgpy3/mjg/blob/master/images/me.jpg?raw=true"

imageStyle : Html.Attribute
imageStyle =
  CommonStyles.image
    [
      ("max-width","60%")
    , ("height","auto")
    ]
