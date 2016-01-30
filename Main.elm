module Main where

import About
import Blog
import Footer
import Header

import Html exposing (div)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp

main =
  StartApp.start { model = init, view = view, update = update }

type Action =
  HeaderAction Header.Action
  | BlogAction Blog.Action

type alias Model =
  { blog : Blog.Model
  , header : Header.Model
  }

init : Model
init =
  { blog = Blog.init
  , header = Header.init
  }

view : Signal.Address Action -> Model -> Html.Html
view address model =
  let
    currentBody = case model.header of
      Header.About -> About.view
      Header.Blog -> Blog.view (Signal.forwardTo address BlogAction) model.blog
  in
    div []
      [ Header.view (Signal.forwardTo address HeaderAction) model.header
      , div [contentStyle] [currentBody, Footer.view]
      ]

update : Action -> Model -> Model
update action model = case action of
  HeaderAction headerAction -> { model | header = Header.update headerAction model.header }
  BlogAction blogAction -> { model | blog = Blog.update blogAction model.blog }

contentStyle : Html.Attribute
contentStyle =
  style
    [
      ("margin-left", "10%")
    , ("margin-right", "10%")
    , ("margin-top", "50px")
    ]
