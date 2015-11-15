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
componentToHtml (Code lang text) = concat ["<pre><code class=\"", toLower $ show lang, "\">\n", text, "\n</code></pre>\n"]

contentToHtml : Content -> String
contentToHtml cs = concatMap componentToHtml cs

postToHtml : Post -> (String, String)
postToHtml (BlogPost title tags date content) = (fileName date title, contentToHtml content)

object_oriented_clojure_example : Post
object_oriented_clojure_example =
  BlogPost "Object Oriented Clojure Example" [ClojureTag, FPTag, OOPTag, ProgrammingTag] (2015, 06, 28) [
    Text [
      Plain "Inspired by the message passing content in",
      Link
        "The Structure and Interpretation of Computer Programs"
        "http://www.amazon.com/Structure-Interpretation-Computer-Programs-Engineering/dp/0262510871",
      Plain "(SICP), I decided to try my hand at object oriented-style programming in Clojure. Here's what I came up with, using the traditional bank account example"
    ],
    Code ClojureLanguage """
(defn make-account [initial-balance]
  (let [bal (ref initial-balance)
        withdraw (fn [amount]
                   (dosync (alter bal #(- % amount))))
        deposit (fn [amount]
                  (dosync (alter bal (partial + amount))))
        amount (fn []
                 (deref bal))
        reset (fn []
                (dosync (ref-set bal initial-balance)))]
    (fn [meth & args]
      (cond
        (= meth :withdraw) (withdraw (first args))
        (= meth :deposit) (deposit (first args))
        (= meth :amount) (amount)
        (= meth :reset) (reset)))))
""",
    Text [
      Plain "Overall, it was a fun little bit of code to write! It has a constructor (make-account), a private variable with mutation (bal) and some messages it responds to (",
      InlineCode ":withdraw",
      Plain ",",
      InlineCode ":deposit",
      Plain ",",
      InlineCode ":amount",
      Plain "and",
      InlineCode ":reset"
    ],
    Text [
      Plain "Here's an example of it being used"
    ],
    Code ClojureLanguage """
(def account (make-account 1000))
(println (account :amount))
; -> 1000

(account :withdraw 75)
(println (account :amount))
; -> 1925

(account :reset)
(println (account :amount))
; -> 1000
"""
  ]
