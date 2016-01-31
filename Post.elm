module Post where

import Html exposing (div, a, code, text, p, pre, h1, br, ul, li, i)
import Html.Attributes exposing (..)
import String

type alias Title = String

type ProgrammingLanguage =
  ClojureLanguage
  | HaskellLanguage
  | IdrisLanguage
  | BashLanguage
  | MappyLanguage

type Tag =
  ClojureTag
  | HaskellTag
  | LispTag
  | MappyTag
  | FPTag
  | OOPTag
  | ProgrammingTag
  | IdrisTag
  | DSATag

type alias Tags = List Tag

type alias Url = String

type TextComponent =
  Plain String
  | Link String Url
  | InlineCode String
  | BulletedList (List (List TextComponent))

type Component =
  Text (List TextComponent)
  | Code ProgrammingLanguage String

type alias Content = List Component

type alias Date = (Int, Int, Int)
--                 YR   MO   Day

type Post = BlogPost Title Tags Date Content

textComponentToHtml : TextComponent -> Html.Html
textComponentToHtml component = case component of
  (Plain content) -> text content
  (Link content url) -> a [target "_blank", href url] [text <| " " ++ content ++ " "]
  (BulletedList items) -> ul [] <| List.map (li [] << List.map textComponentToHtml) items
  (InlineCode content) ->
    code
      [ style
        [("border", "1px solid grey")
        , ("background", "black")
        , ("color", "#64FE2E")
        , ("border-radius", "4px")
        ]
      ]
      [text content]

componentToHtml : Component -> Html.Html
componentToHtml component = case component of
  (Text elements) -> p [] <| List.map textComponentToHtml elements
  (Code lang content) ->
    pre
      [style
        [ ("border", "1px solid grey")
        , ("padding", "10px")
        , ("white-space", "pre-wrap")
        , ("background", "black")
        , ("color", "#64FE2E")
        , ("border-radius", "4px")
        ]
      ]
      [ text content ]

contentToHtml : Content -> Html.Html
contentToHtml cs = div [] <| List.map componentToHtml cs

titleToHtml : String -> (Int, Int, Int) -> Html.Html
titleToHtml title (year, month, day) =
  div
    []
    [ h1
        []
        [ text title ]
    , p [] [text <| toString month ++ "/" ++ toString day ++ "/" ++ toString year]
    , br [] []
    ]

tagsToHtml : List Tag -> Html.Html
tagsToHtml tags =
  tags |>
  List.map (text << tagToString) |>
  List.intersperse (text ", ") |>
  (::) (text "Tags: ") |>
  i []

tagToString : Tag -> String
tagToString tag = case tag of
  ProgrammingTag -> "programming"
  ClojureTag -> "clojure"
  HaskellTag -> "haskell"
  LispTag -> "lisp"
  MappyTag -> "mappy"
  FPTag -> "functional_programming"
  OOPTag -> "object_oriented_programming"
  IdrisTag -> "idris"
  DSATag -> "data_structures_and_algorithms"

postToHtml : Post -> Html.Html
postToHtml (BlogPost title tags date content) =
  div
    []
    [ titleToHtml title date
    , contentToHtml content
    , tagsToHtml tags
    ]
