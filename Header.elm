module Header (Action, Model(..), view, init, update) where

import Html exposing (a, h1, text, div)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type Model = Blog | About

init : Model
init = About

items : List (String, Model)
items =
  [ ("About", About)
  , ("Blog", Blog)
  ]

itemAsHtml : Signal.Address Action -> Model -> (String, Model) -> Html.Html
itemAsHtml address selected (value, option) =
  let
    style = if option == selected
            then selectedItemStyle
            else itemStyle
  in
    a [style, onClick address { selectedModel = option }]
      [div
        []
        [text value]]

selectedItemStyle : Html.Attribute
selectedItemStyle =
  baseItemStyle
    [
      ("text-decoration", "underline")
    ]

itemStyle : Html.Attribute
itemStyle =
  baseItemStyle
    [
    ]

baseItemStyle : List (String, String) -> Html.Attribute
baseItemStyle styles =
  style
    ([
        ("height", "100%")
      , ("color", "grey")
      , ("display", "inline-block")
      , ("font-size", "3em")
      , ("padding-left", "0.75em")
      , ("padding-right", "0.75em")
      , ("text-decoration", "none")
      , ("cursor", "pointer")
    ] ++ styles)

view : Signal.Address Action -> Model -> Html.Html
view address model =
  div [headerStyle] <| List.map (itemAsHtml address model) items

headerStyle : Html.Attribute
headerStyle =
  style
    [
      ("text-align", "center")
    , ("background", "black")
    , ("height", "4em")
    , ("width", "100%")
    , ("border-radius", "5px")
    ]

type alias Action = { selectedModel : Model }

update : Action -> Model -> Model
update action _ = action.selectedModel
