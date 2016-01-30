module Main where

import Header

import Html exposing (div, button, text)
import StartApp.Simple as StartApp

main =
  StartApp.start { model = Header.init, view = view, update = Header.update }

view address model =
  div []
    [ Header.view address model ]
