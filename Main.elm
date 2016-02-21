module Main where

import About
import Blog
import Footer
import Header

import Html exposing (div)
import Html.Attributes exposing (..)
import StartApp
import Effects
import RouteHash
import Task
import String

app =
  StartApp.start {
      init = init
    , view = view
    , update = update
    , inputs = [ messages.signal ]
  }

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
  Header.Blog -> case new.blog.selectedPostId of
    Nothing -> Just <| RouteHash.set ["blog"]
    Just blog -> Just <| RouteHash.set ["blog", toString blog]
  Header.About -> Just <| RouteHash.set ["about"]

location2action : List String -> List Action
location2action location = case location of
  ("blog"::rest) -> [
      HeaderAction { selectedModel = Header.Blog }
    , blogLocation rest
    ]
  _ -> [HeaderAction { selectedModel = Header.About }]

blogLocation : List String -> Action
blogLocation components =
  case components of
    [id] ->
      case String.toInt id of
        (Ok intId) -> BlogAction <| Blog.SelectPost intId
        (Err _) -> BlogAction Blog.MoveToList
    _ ->
      BlogAction Blog.MoveToList

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
    div [
      ]
      [ Header.view (Signal.forwardTo address HeaderAction) model.header
      , div [contentStyle] [currentBody]
      , div [] [Footer.view]
      ]

update : Action -> Model -> (Model, Effects.Effects Action)
update action model = (case action of
    HeaderAction headerAction -> {
      blog = (fst init).blog,
      header = Header.update headerAction model.header
    }
    BlogAction blogAction -> { model |
      blog = Blog.update blogAction model.blog
    }
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
    , ("margin-bottom", "50px")
    , ("margin-top", "50px")
    , ("font-size", "x-large")
    ]
