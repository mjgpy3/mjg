module Footer (view) where

import Html exposing (div, h1, text, img, a)
import Html.Attributes exposing (..)

view : Html.Html
view =
  div
    [
      style
        [
          ("width", "100%")
        , ("padding-top", "20px")
        , ("padding-bottom", "20px")
        , ("background-color", "SlateGrey")
        , ("border-radius", "5px")
        ]
    ]
    [footerContent]

styleOnly : List (String, String) -> Html.Html
styleOnly attrs = div [style attrs] []

footerContent : Html.Html
footerContent =
  div [
    style [
    ]
  ]
  (items |> List.map linkImage)

linkImage : (String, String) -> Html.Html
linkImage (link, image) =
  a [
      href link
    , style
      [
        ("padding-left", "10px")
      , ("padding-right", "10px")
      ]
    ]
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
