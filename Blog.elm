module Blog (Action, Model, view, init, update) where

import Html exposing (div, p, text)

import Posts

type alias Action = Posts.Action

type alias Model =  Posts.Model

init : Model
init = Posts.init

update : Action -> Model -> Model
update = Posts.update

view : Signal.Address Posts.Action -> Posts.Model -> Html.Html
view address model =
  div []
    [ Posts.view address model ]
