module Main where

import About
import Blog
import Footer
import Header

import Html exposing (div)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp

type alias Model = Header.Model

main =
  StartApp.start { model = Header.init, view = view, update = Header.update }

view address model =
  let
    currentBody = case model of
      Header.About -> About.view
      Header.Blog -> Blog.view
  in
    div []
      [ Header.view address model
      , div [contentStyle] [currentBody, Footer.view]
      ]

contentStyle : Html.Attribute
contentStyle =
  style
    [
      ("margin-left", "10%")
    , ("margin-right", "10%")
    , ("margin-top", "50px")
    ]
