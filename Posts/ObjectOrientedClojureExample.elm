module Posts.ObjectOrientedClojureExample (post) where

import Post exposing (..)
import Html

post : Post.Post
post = object_oriented_clojure_example

object_oriented_clojure_example : Post
object_oriented_clojure_example =
  BlogPost "Object Oriented Clojure Example" [ClojureTag, FPTag, OOPTag, ProgrammingTag, SICPTag] (2015, 06, 28) [
    Text [
      Plain "Inspired by the message passing content in",
      Link
        "The Structure and Interpretation of Computer Programs"
        "http://www.amazon.com/Structure-Interpretation-Computer-Programs-Engineering/dp/0262510871",
      Plain "(SICP), I decided to try my hand at object oriented-style programming in Clojure. Here's what I came up with, using the traditional bank account example"
    ],
    Code ClojureLanguage """(defn make-account [initial-balance]
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
      Plain ", ",
      InlineCode ":deposit",
      Plain ", ",
      InlineCode ":amount",
      Plain " and ",
      InlineCode ":reset",
      Plain ")"
    ],
    Text [
      Plain "Here's an example of it being used"
    ],
    Code ClojureLanguage """(def account (make-account 1000))
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
