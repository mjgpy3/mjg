module Footer (view) where

import Html exposing (div, h1, text, img, a)
import Html.Attributes exposing (..)

view : Html.Html
view =
  div
    [style [("padding-top", "20px"), ("width", "30%"), ("margin", "auto")]]
    [footerContent]

connector : Html.Html
connector =
  div
    [style [
      ("width", "15px")
    , ("height", "5px")
    , ("background", "#970202")
    , ("display", "inline-block")
    , ("margin-left", "10px")
    , ("margin-right", "10px")
    , ("margin-bottom", "8px")
    ]]
    [ ball ("15px", "-3px")
    , ball ("-5px", "-13px")
    ]

styleOnly : List (String, String) -> Html.Html
styleOnly attrs = div [style attrs] []

ball : (String, String) -> Html.Html
ball (left, top) =
  styleOnly
    [
      ("content", "")
    , ("display", "block")
    , ("width", "5px")
    , ("height", "10px")
    , ("position", "relative")
    , ("left", left)
    , ("top", top)
    , ("background", "#970202")
    , ("border-radius", "5px")
    , ("display", "")
    ]

footerContent : Html.Html
footerContent =
  div []
  (items |> List.map linkImage |> List.intersperse connector)

linkImage : (String, String) -> Html.Html
linkImage (link, image) =
  a [href link, style [("display", "inline-block")]]
    [img [src <| "https://github.com/mjgpy3/mjg/blob/master/images/" ++ image ++ "?raw=true"] []]

items : List (String, String)
items =
  [ ("https://github.com/mjgpy3", "glyphicons-social-22-github.png")
  , ("https://twitter.com/mjgpy3", "glyphicons-social-32-twitter.png")
  , ("http://michaeljgilliland.blogspot.com/", "glyphicons-social-6-blogger.png")
  , ("https://www.linkedin.com/in/mjgpy3", "glyphicons-social-18-linked-in.png")
  , ("http://stackoverflow.com/users/1378292/mjgpy3", "glyphicons-social-65-stackoverflow.png")
  , ("mailto:mjg.py3@gmail.com", "glyphicons-social-19-gmail.png")
  ]
