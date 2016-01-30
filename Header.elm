module Header (Action, Model(..), view, init, update) where

import Html exposing (div, h1, text)
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
    div [style, onClick address { selectedModel = option }]
      [div
        []
        [text value]]

selectedItemStyle : Html.Attribute
selectedItemStyle =
  baseItemStyle
    [
      ("color", "#970202")
    , ("text-shadow", "2px 3px 5px rgba(60,50,9,0.3)")
    ]

itemStyle : Html.Attribute
itemStyle =
  baseItemStyle
    [
      ("color", "#F02424")
    , ("text-shadow", "2px 3px 5px rgba(0,0,9,0.3)")
    ]

baseItemStyle : List (String, String) -> Html.Attribute
baseItemStyle styles =
  style
    ([
      ("height", "50px")
    , ("padding-left", "10px")
    , ("padding-right", "10px")
    , ("font-weight", "bold")
    , ("font-size", "x-large")
    , ("background", "#585858")
    , ("display", "inline-block")
    , ("position", "relative")
    , ("left", "40%")
    , ("border-radius", "5px")
    , ("margin", "10px")
    , ("text-align", "center")
    , ("cursor", "pointer")
    ] ++ styles)

titleStyle : Html.Attribute
titleStyle =
  style
    [ ("color", "white")
    , ("position", "absolute")
    , ("display", "inline-block")
    , ("margin", "10px")
    , ("text-align", "center")
    ]

view : Signal.Address Action -> Model -> Html.Html
view address model =
  div [headerStyle] <| [h1 [titleStyle] [text "MJG"]] ++ List.map (itemAsHtml address model) items

headerStyle : Html.Attribute
headerStyle =
  style
    [
      ("width", "100%")
    , ("height", "70px")
    , ("background", "black")
    ]

type alias Action = { selectedModel : Model }

update : Action -> Model -> Model
update action _ = action.selectedModel
