module Tags where

import Tag exposing (..)

import Html exposing (text, i)

tagsToHtml : List Tag -> Html.Html
tagsToHtml tags =
  tags |>
  List.map (text << tagToString) |>
  List.intersperse (text ", ") |>
  (::) (text "Tags: ") |>
  i []

singleton : a -> List a
singleton a = [a]
