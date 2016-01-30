module Posts (Action, Model, update, view) where

import Html exposing (div, h1, text)

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
view address model = div [] []

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
postById id = Nothing {- TODO -}

postsWithIds : List (Int, Post.Post)
postsWithIds =
  allPosts |>
  List.map fst |>
  List.map2 (,) [1..List.length allPosts]

allPosts : List (Post.Post, Html.Html)
allPosts =
  [ Posts.ObjectOrientedClojureExample.post
  ]
