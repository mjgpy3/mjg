module CommonElements where

import Html exposing (a)
import Html.Attributes exposing (..)

internalLink : List Html.Attribute -> List Html.Html -> Html.Html
internalLink attrs elems =
  a
    (style [
      ("color", "blue")
    , ("text-decoration", "underline")
    , ("cursor", "pointer")]::attrs)
    elems
