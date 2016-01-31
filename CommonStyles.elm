module CommonStyles where

import Html
import Html.Attributes exposing (..)

image : List (String, String) -> Html.Attribute
image attrs =
  style
    ([
      ("margin-left", "auto")
    , ("margin-right", "auto")
    , ("display", "block")
    , ("height","auto")
    ] ++ attrs)
