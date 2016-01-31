module Post where

import Html exposing (..)
import Html.Attributes exposing (..)
import String
import CommonStyles

type alias Title = String

type ProgrammingLanguage =
  ClojureLanguage
  | HaskellLanguage
  | IdrisLanguage
  | BashLanguage
  | MappyLanguage
  | RubyLanguage

type Tag =
  ClojureTag
  | HaskellTag
  | LispTag
  | MappyTag
  | FPTag
  | OOPTag
  | ProgrammingTag
  | SoftwareEngineeringTag
  | DeletingCodeTag
  | IdrisTag
  | DSATag
  | SchemeTag
  | MonadTag
  | SICPTag
  | RubyTag

type alias Tags = List Tag

type alias Url = String

type TextComponent =
  Plain String
  | Emph String
  | Link String Url
  | InlineCode String
  | BulletedList (List (List TextComponent))
  | NumberedList (List (List TextComponent))

type Component =
  Text (List TextComponent)
  | Code ProgrammingLanguage String
  | Quote (List TextComponent)
  | Section String (List Component)
  | Img (Maybe Int) String
 
type alias Content = List Component

type alias Date = (Int, Int, Int)
--                 YR   MO   Day

type Post = BlogPost Title Tags Date Content

textComponentToHtml : TextComponent -> Html.Html
textComponentToHtml component = case component of
  (Plain content) -> text content
  (Emph content) -> i [] [text content]
  (Link content url) -> a [target "_blank", href url] [text <| " " ++ content ++ " "]
  (BulletedList items) -> list ul items
  (NumberedList items) -> list ol items
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

list : (List Html.Attribute -> List Html.Html -> Html.Html) -> (List (List TextComponent)) -> Html.Html
list f items = f [] <| List.map (li [] << List.map textComponentToHtml) items

componentToHtml : Component -> Html.Html
componentToHtml component = case component of
  (Text elements) -> p [] <| List.map textComponentToHtml elements
  (Quote components) -> blockquote [] <| List.map textComponentToHtml components
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
  (Section title components) ->
    div [] <| h2 [] [text title]::List.map componentToHtml components
  (Img scale assetname) ->
    img
      [ CommonStyles.image
        [ ("max-width", (toString <| Maybe.withDefault 60 scale) ++ "%")
        , ("border-radius", "10px")
        , ("border", "5px solid black")
        ]
      , src <| "https://github.com/mjgpy3/mjg/blob/master/images/" ++ assetname ++ "?raw=true"
      ]
      []

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
  SICPTag -> "struct_and_interp_of_computer_programs"
  RubyTag -> "ruby"
  SoftwareEngineeringTag -> "software_engineering"
  DeletingCodeTag -> "deleting_code"
  SchemeTag -> "scheme"
  MonadTag -> "monad"

postToHtml : Post -> Html.Html
postToHtml (BlogPost title tags date content) =
  div
    []
    [ titleToHtml title date
    , contentToHtml content
    , tagsToHtml tags
    ]
