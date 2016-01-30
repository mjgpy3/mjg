module Header (Action, Model, view, init, update) where

import Html exposing (div, button, text)
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
  div []
    [button [onClick address { selectedModel = option }] [text (if option == selected then value ++ "*" else value)]]

view : Signal.Address Action -> Model -> Html.Html
view address model =
  div [headerStyle] (List.map (itemAsHtml address model) items)

headerStyle : Html.Attribute
headerStyle =
  style
    [
      ("width", "100%")
    , ("height", "60px")
    , ("background", "black")
    ]

type alias Action = { selectedModel : Model }

update : Action -> Model -> Model
update action _ = action.selectedModel
