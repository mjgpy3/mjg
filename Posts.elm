module Posts (Action, Model, update, view, init) where

import Html exposing (div, h1, text, button)
import Html.Events exposing (onClick)

import Html
import Post
import Posts.ObjectOrientedClojureExample
import Dict

type alias Model =
  Maybe
  { selectedPostId : Int
  }

init : Model
init = Nothing

view : Signal.Address Action -> Model -> Html.Html
view address model = case model of
  Nothing -> postList address
  Just post -> singlePost address post.selectedPostId

postList : Signal.Address Action -> Html.Html
postList address = div
  []
  [button [onClick address <| SelectPost 1] [text "select 1"]]

singlePost : Signal.Address Action -> Int -> Html.Html
singlePost address id = div
  []
  [button [onClick address MoveToList] [text "Back"]]

type Action = MoveToList | SelectPost Int

update : Action -> Model -> Model
update action model = case action of
  MoveToList -> init
  SelectPost id -> Just { selectedPostId = id }

monthYearToPost : Dict.Dict (Int, Int) (List (Int, Post.Post))
monthYearToPost =
  let
    getWithDefault def k d = Maybe.withDefault def <| Dict.get k d
    reducer ((id, (Post.BlogPost _ _ (year, month, _) _)) as post) r =
      let key = (year, month)
      in Dict.insert key (post::getWithDefault [] key r) r
  in
    List.foldr reducer Dict.empty postsWithIds

postById : Int -> Maybe Post.Post
postById id =
  postsWithIds |>
  Dict.fromList |>
  Dict.get id

postsWithIds : List (Int, Post.Post)
postsWithIds =
  allPosts |>
  List.map fst |>
  List.map2 (,) [1..List.length allPosts]

allPosts : List (Post.Post, Html.Html)
allPosts =
  [ Posts.ObjectOrientedClojureExample.post
  ]
