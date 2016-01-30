module Post where

import Html exposing (div, a, code, text, p, pre)
import Html.Attributes exposing (..)
import String

type alias Title = String

type ProgrammingLanguage = ClojureLanguage

languageToString : ProgrammingLanguage -> String
languageToString lang = case lang of
  ClojureLanguage -> "clojure"

type Tag = ClojureTag | FPTag | OOPTag | ProgrammingTag

type alias Tags = List Tag

type alias Url = String

type TextComponent =
  Plain String
  | Link String Url
  | InlineCode String

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
  (Link content url) -> a [target "_blank", href url] [text content]
  (InlineCode content) -> code [] [text content]

componentToHtml : Component -> Html.Html
componentToHtml component = case component of
  (Text elements) -> p [] <| List.map textComponentToHtml elements
  (Code lang content) -> pre [] [text content]

contentToHtml : Content -> Html.Html
contentToHtml cs = div [] <| List.map componentToHtml cs

postToHtml : Post -> Html.Html
postToHtml (BlogPost title tags date content) = div [] [contentToHtml content]
