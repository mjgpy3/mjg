module Posts.OOPSettersPartialApplication (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "OOP Setters Can be Used to Emulate Partial Application" [ClojureTag, FPTag, OOPTag, ProgrammingTag, HaskellTag, RubyTag] (2015, 4, 9) [
    Text [
      Plain "Recently I was asked an awesome question that went something like"
    ],
    Quote [
      Plain "How would you do something like high-order functions and",
      Link
        "partial application"
        "http://en.wikipedia.org/wiki/Partial_application",
      Plain "in object-oriented programming?"
    ],
    Text [
      Plain "For high-order function my mind immediately jumped to Guava's Function Interface. I said, \"hmmmm, let's see, could have some method (maybe called ",
      InlineCode "partiallyApply",
      Plain ") that took an argument and returned another ",
      InlineCode "Function",
      Plain ".\" In retrospect, this may have been overly complex, and a much simpler implementation of ",
      InlineCode "Function",
      Plain "may work just as well in this case: ",
      Link
        "fluent setters."
        "http://en.wikipedia.org/wiki/Fluent_interface"
    ],
    Text [
      Plain "Let's look at a contrived, dead-horse-esque example. A partial function that does addition on two arguments."
    ],
    Text [
      Plain "In Haskell, if I wanted to build such a function, and partially apply it to, let's say 5, I might do the following"
    ],
    Code HaskellLanguage """add5 = (+) 5

add5 10 -- is 15
""",
    Text [Plain "In Clojure, this might look like"],
    Code ClojureLanguage """(def add-5 (partial + 5))

(add-5 10) ; is 15
""",
    Text [Plain "So, how would I do this using setters? Simple! Here's some Ruby code"],
    Code RubyLanguage """class Adder
  def value(first)
    @first = first
    self
  end

  def to(second)
    @second = second
    self
  end

  def add
    @first + @second
  end
end

adder_of_5 = Adder.new.value(5)

adder_of_5.to(10).add # is 15
""",
    Text [
      Plain "This code (obviously) has a lot more ceremony wrapped around it, but it does achieve some of the same benefits as partial application (e.g. laziness, partial parameter fulfillment). The point is, if this were Java code, I could easily implement ",
      InlineCode "Function",
      Plain " and change ",
      InlineCode "add",
      Plain " to ",
      InlineCode "invoke",
      Plain " and have a partial function in an object-oriented system."
    ]
  ]

