module Posts.OOPSettersPartialApplication (post) where

import Post exposing (..)
import Html

import Tag

post : Post
post =
  BlogPost "OOP Setters Can be Used to Emulate Partial Application" [Tag.Clojure, Tag.FP, Tag.OOP, Tag.Programming, Tag.Haskell, Tag.Ruby] (2015, 4, 9) [
    Text [
      pl "Recently I was asked an awesome question that went something like"
    ],
    Quote [
      pl "How would you do something like high-order functions and ",
      "partial application" ->> "http://en.wikipedia.org/wiki/Partial_application",
      pl " in object-oriented programming?"
    ],
    Text [
      pl "For high-order function my mind immediately jumped to Guava's Function Interface. I said, \"hmmmm, let's see, could have some method (maybe called ",
      c "partiallyApply",
      pl ") that took an argument and returned another ",
      c "Function",
      pl ".\" In retrospect, this may have been overly complex, and a much simpler implementation of ",
      c "Function",
      pl "may work just as well in this case: ",
      "fluent setters" ->> "http://en.wikipedia.org/wiki/Fluent_interface",
      pl "."
    ],
    Text [
      pl "Let's look at a contrived, dead-horse-esque example. A partial function that does addition on two arguments."
    ],
    Text [
      pl "In Haskell, if I wanted to build such a function, and partially apply it to, let's say 5, I might do the following"
    ],
    Code HaskellLanguage """add5 = (+) 5

add5 10 -- is 15
""",
    Text [pl "In Clojure, this might look like"],
    Code ClojureLanguage """(def add-5 (partial + 5))

(add-5 10) ; is 15
""",
    Text [pl "So, how would I do this using setters? Simple! Here's some Ruby code"],
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
      pl "This code (obviously) has a lot more ceremony wrapped around it, but it does achieve some of the same benefits as partial application (e.g. laziness, partial parameter fulfillment). The point is, if this were Java code, I could easily implement ",
      c "Function",
      pl " and change ",
      c "add",
      pl " to ",
      c "invoke",
      pl " and have a partial function in an object-oriented system."
    ]
  ]

