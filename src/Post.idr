module Post

Title : Type
Title = String

data ProgrammingLanguage =
  ClojureLanguage

instance Show ProgrammingLanguage where
  show ClojureLanguage = "Clojure"

data Tag =
  ClojureTag
  | FPTag
  | OOPTag
  | ProgrammingTag

Tags : Type
Tags = List Tag

Url : Type
Url = String

data TextComponent =
  Plain String
  | Link String Url
  | InlineCode String

data Component =
  Text (List TextComponent)
  | Code ProgrammingLanguage String

Content : Type
Content =
  List Component

Date : Type
Date = (Int, Int, Int)
--      YR   MO   Day

data Post =
  BlogPost Title Tags Date Content

fileName : Date -> String -> String
fileName (year, month, day) title = concat [
  show year
  ,"_", show month
  ,"_", show day
  ,"_", urlify title
  ,".html"]
  where
    urlify = concat . intersperse "-" . split (not . isAlphaNum)

textComponentToString : TextComponent -> String
textComponentToString (Plain text) = text ++ " "
textComponentToString (Link text url) = concat ["<a target=\"_blank\" href=\"", url, "\">", text, "</a> "]
textComponentToString (InlineCode code) = concat ["<code>", code, "</code> "]

componentToHtml : Component -> String
componentToHtml (Text elements) = concat ["<p>", concat $ map textComponentToString elements, "</p>\n"]
componentToHtml (Code lang text) = concat ["<pre><code class=\"", toLower $ show lang, "\">", text, "</code></pre>\n"]

contentToHtml : Content -> String
contentToHtml cs = concatMap componentToHtml cs

postToHtml : Post -> (String, String)
postToHtml (BlogPost title tags date content) = (fileName date title, contentToHtml content)
