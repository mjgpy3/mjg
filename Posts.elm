module Posts (Action, Model, update, view, init) where

import Html exposing (div, h1, h3, text, button, ul, li, a)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

import Html
import Post
import Dict
import Posts.IntroducingMappy
import Posts.ObjectOrientedClojureExample
import Posts.TrieInHaskell
import Posts.WriteAFileInIdris

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
  [] <| [ul [] <| Dict.foldr (toMonthList address) [] yearMonthToPost]

toMonthList : Signal.Address Action -> (Int, Int) -> List (Int, Post.Post) -> List Html.Html -> List Html.Html
toMonthList address (year, month) posts list = list ++ [
  li [] [
      text <| toString month ++ "/" ++ toString year
    , ul [] <| List.map (toPost address) posts
    ]
  ]

toPost : Signal.Address Action -> (Int, Post.Post) -> Html.Html
toPost address (id, Post.BlogPost title _ _ _) =
  a
    [href "#", onClick address <| SelectPost id]
    [text title]

singlePost : Signal.Address Action -> Int -> Html.Html
singlePost address id = div
  []
  [ a [onClick address MoveToList, href "#"] [text "Archive"]
  , case postHtmlById id of
      Nothing -> div [] [h3 [] [text "Post not found!"]]
      Just post -> Post.postToHtml post
  ]

type Action = MoveToList | SelectPost Int

update : Action -> Model -> Model
update action model = case action of
  MoveToList -> init
  SelectPost id -> Just { selectedPostId = id }

yearMonthToPost : Dict.Dict (Int, Int) (List (Int, Post.Post))
yearMonthToPost =
  let
    getWithDefault def k d = Maybe.withDefault def <| Dict.get k d
    reducer ((id, (Post.BlogPost _ _ (year, month, _) _)) as post) r =
      let key = (year, month)
      in Dict.insert key (post::getWithDefault [] key r) r
  in
    List.foldr reducer Dict.empty postsWithIds

postHtmlById : Int -> Maybe Post.Post
postHtmlById id =
  postsWithIds |>
  Dict.fromList |>
  Dict.get id

postsWithIds : List (Int, Post.Post)
postsWithIds =
  allPosts |>
  List.map2 (,) [1..List.length allPosts]

allPosts : List Post.Post
allPosts =
  [ Posts.IntroducingMappy.post
  , Posts.ObjectOrientedClojureExample.post
  , Posts.TrieInHaskell.post
  , Posts.WriteAFileInIdris.post
  ]
