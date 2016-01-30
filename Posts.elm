module Posts where

import Html
import Post
import Posts.ObjectOrientedClojureExample

allPosts : List (Post.Post, Html.Html)
allPosts =
  [ Posts.ObjectOrientedClojureExample.post
  ]
