module Post where

type alias Title = String

type ProgrammingLanguage = ClojureLanguage

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
