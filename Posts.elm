module Posts (yearMonthToPost, postById) where

import Post
import Posts.FavorDeletableCodeOverReusableCode
import Posts.FunctionalProgrammingAhaMoments
import Posts.IntroducingMappy
import Posts.OOPSettersPartialApplication
import Posts.ObjectOrientedClojureExample
import Posts.TrieInHaskell
import Posts.WriteAFileInIdris

import Dict

yearMonthToPost : Dict.Dict (Int, Int) (List (Int, Post.Post))
yearMonthToPost =
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

postsWithIds  : List (Int, Post.Post)
postsWithIds =
  [ (100, Posts.IntroducingMappy.post)
  , (99, Posts.ObjectOrientedClojureExample.post)
  , (98, Posts.TrieInHaskell.post)
  , (97,Posts.WriteAFileInIdris.post)
  , (96,Posts.FavorDeletableCodeOverReusableCode.post)
  , (95,Posts.FunctionalProgrammingAhaMoments.post)
  , (94,Posts.OOPSettersPartialApplication.post)
  ]
