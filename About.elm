module About (view) where

import CommonStyles

import Html exposing (div, p, img, text)
import Html.Attributes exposing (..)

view : Html.Html
view =
  div []
    [
      p [] [text "My name is Michael Gilliland. I'm a software engineer who enjoys functional programming, testing, collaboratively building software and problem solving."]
    , p [] [text "Here's a picture of me walking around Pittsburgh"]
    , img [src "https://github.com/mjgpy3/mjg/blob/master/images/me.jpg?raw=true", imageStyle] []
    ]

imageStyle : Html.Attribute
imageStyle =
  CommonStyles.image
    [
      ("max-width","100%")
    , ("height","auto")
    ]
