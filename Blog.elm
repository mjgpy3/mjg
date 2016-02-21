module Blog (Action(..), Model, view, init, update) where

import Html exposing (div, h3, text, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Dict

import CommonElements exposing (internalLink)
import Posts
import Post

type Action = MoveToList | SelectPost Int

type alias Model =
  { selectedPostId : Maybe Int
  }

init : Model
init = { selectedPostId = Nothing }

view : Signal.Address Action -> Model -> Html.Html
view address model = case model.selectedPostId of
  Nothing -> postList address
  Just post -> singlePost address post

update : Action -> Model -> Model
update action model = case action of
  MoveToList -> init
  SelectPost id -> { selectedPostId = Just id }

postList : Signal.Address Action -> Html.Html
postList address = div
  [] <| [ul [] <| Dict.foldr (toMonthList address) [] Posts.yearMonthToPost]

toMonthList : Signal.Address Action -> (Int, Int) -> List (Int, Post.Post) -> List Html.Html -> List Html.Html
toMonthList address (year, month) posts list = list ++ [
  li [
    style [("padding", "5px"), ("list-style-type", "none")]
    ] [
      text <| toString month ++ "/" ++ toString year
    , ul [
      style [("list-style-type", "none")]
      ] <| List.map (toPost address) posts
    ]
  ]

toPost : Signal.Address Action -> (Int, Post.Post) -> Html.Html
toPost address (id, Post.BlogPost title _ _ _) =
  li
    []
    [internalLink
      [onClick address <| SelectPost id]
      [text title]
    ]

singlePost : Signal.Address Action -> Int -> Html.Html
singlePost address id = div
  []
  [ internalLink [onClick address MoveToList] [text "Archive"]
  , case Posts.postById id of
      Nothing -> div [] [h3 [] [text "Post not found!"]]
      Just post -> Post.postToHtml post
  ]
