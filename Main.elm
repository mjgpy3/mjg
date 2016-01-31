module Main where

import About
import Blog
import Footer
import Header
import Posts

import Html exposing (div)
import Html.Attributes exposing (..)
import StartApp
import Effects
import RouteHash
import Task
import String

app =
  StartApp.start { init = init, view = view, update = update, inputs = [ messages.signal ] }

main =
  app.html

port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks

messages : Signal.Mailbox Action
messages = Signal.mailbox NoOp

port routeTasks : Signal (Task.Task () ())
port routeTasks =
    RouteHash.start
        { prefix = RouteHash.defaultPrefix
        , address = messages.address
        , models = app.model
        , delta2update = delta2update
        , location2action = location2action
        }

delta2update : Model -> Model -> Maybe RouteHash.HashUpdate
delta2update _ new = case new.header of
  Header.Blog -> case new.blog of
    Nothing -> Just <| RouteHash.set ["blog"]
    Just blog -> Just <| RouteHash.set ["blog", toString blog.selectedPostId]
  Header.About -> Just <| RouteHash.set ["about"]

location2action : List String -> List Action
location2action location = case location of
  ["blog"] ->
    [
      HeaderAction { selectedModel = Header.Blog },
      BlogAction Posts.MoveToList
    ]
  ["blog", id] ->
    [ HeaderAction { selectedModel = Header.Blog }
    , case String.toInt id of
      Ok intId -> BlogAction <| Posts.SelectPost intId
      Err _ -> BlogAction Posts.MoveToList
    ]
  _ -> [HeaderAction { selectedModel = Header.About }]

type Action =
  HeaderAction Header.Action
  | BlogAction Blog.Action
  | NoOp

type alias Model =
  { blog : Blog.Model
  , header : Header.Model
  }

init : (Model, Effects.Effects Action)
init =
  ( { blog = Blog.init
    , header = Header.init
    },
    Effects.none
  )

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

update : Action -> Model -> (Model, Effects.Effects Action)
update action model = (case action of
    HeaderAction headerAction -> { model | header = Header.update headerAction model.header }
    BlogAction blogAction -> { model | blog = Blog.update blogAction model.blog }
    NoOp -> model
  ,
    Effects.none
  )

contentStyle : Html.Attribute
contentStyle =
  style
    [
      ("margin-left", "10%")
    , ("margin-right", "10%")
    , ("margin-top", "50px")
    ]
