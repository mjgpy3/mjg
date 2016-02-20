module Posts.FunctionalProgrammingAhaMoments (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "Functional Programming Aha! Moments" [ClojureTag, FPTag, HaskellTag, LispTag, MonadTag, SICPTag, SchemeTag] (2015, 5, 19) [
    Text [
      pl "In the past couple of years, I've dedicated a fair amount of time to closet-functional-programming. Although I haven't gotten an opportunity to use a more purist functional programming language (e.g. not Framework_of_the_day.JS) in my day-to-day day, industry work, I believe some of the values of functional programming have bled into my daily practice, for the better."
    ],
    Text [
      pl "Industry aside, I want to share some of the \"Aha! moments\" I've had while learning about functional programming. These are moments where something just clicked for me; some part of me almost can't help but share them."
    ],
    Section "Lets can be described by anonymous functions" [
      Text [
        pl "Although \"functional programming\" is one of those things were if you ask five people for a definition you are likely to get six different definitions, one general consensus seems to hold: assignment should be reduced, minimally scoped or eliminated entirely in functional programming."
      ],
      Text [
        pl "The let macro/expression/sugar is basically a means of reducing assignments into minimally scoped, (generally) non-mutative expressions with a set of bindings. Here's a contrived example of what this might look like in Clojure"
      ],
      Img (Just 80) "fp_aha_1.png",
      Text [
        pl "Here we're saying, let's bind ",
        c "x",
        pl " to ",
        c "35",
        pl " then ",
        c "y",
        pl " to a value calculated from ",
        c "x",
        pl ", then we'll use ",
        c "y",
        pl " to calculate some result. This entire expression is just that, it's an expression. This ",
        c "let",
        pl " is evaluated as a whole, and the result is simply ",
        c "42",
        pl "."
      ],
      Text [
        pl "So, here comes the first \"Aha!\" This same kind of scoped assignment can be done through applying anonymous functions! Here's what that looks like for the above example"
      ],
      Img (Just 80) "fp_aha_2.png",
      Text [
        pl "Basically the pattern here is just, for each bound symbol (in this case ",
        c "x",
        pl " and ",
        c "y",
        pl ") nest and call an anonymous function, passing the bound value down (",
        c "35",
        pl " and ",
        c "(- x 14)",
        pl ")! I found this discovery exceptionally cool because it further emphasized the power of these functional languages: something as simple as anonymous functions can be combined to form powerful abstractions. "
      ]
    ],
    Section "Monadic bind is like method chaining" [
      Text [
        pl "Monads, in general, have provided many an \"Aha\" for me. They're definitely one of those constructs where, once you get passed the initial \"this is slightly out of my comfort zone\" feeling, you are ready to embrace an overwhelming amount of power.",
        c "bind",
        pl "(symbolically ",
        c ">>=",
        pl ") is one of the crucial operations implementable by a monad, it has the following type signature"
      ],
      Img (Just 80) "fp_aha_3.png",
      Text [
        pl "Ignoring currying and some other subtleties, if I'm thinking in an \"object oriented mindset\" I might reason about this as follows",
        BulletedList [
          [ c "bind"
          , pl " is a function that take 2 arguments"
          , BulletedList [
             [ pl "a generic wrapper around some type ", c "a" ],
             [ pl "a function which takes some ", c "a", pl "and returns some generic wrapper around type ", c "b", pl " (where ", c "b", pl " may be the same type as ", c "a", pl ")" ]
            ]
          ],
          [ c "bind", pl " returns some generic wrapper around type ", c "b" ]
        ]
      ],
      Text [
        pl "To me, this sounds exactly like a single call that enables method chaining! Think a la calling ",
        c "bind",
        pl " to transform from monad to monad to monad... In my mind, ",
        c "bind",
        pl " is an enabling feature, that allows Haskell code to be elegant, expressive and powerful without lacking type safety (see ",
        "do-notation" ->> "http://en.wikibooks.org/wiki/Haskell/do_notation",
        pl ")."
      ],
      Text [
        pl "To visualize how this is kind of like method chaining, observe the following Ruby code"
      ],
      Img (Just 80) "fp_aha_4.png",
      Text [
        pl "We can imagine these calls (with the exception of ",
        c "count",
        pl ") being like a type-not-so-safe version of Haskell's ",
        c "bind",
        pl " applied a couple of times (2 to be exact). Here are what the steps might look like",
        NumberedList [
          [c "m a", pl " is a range of ", c "Fixnum", pl " (e.g. ", c "Range Fixnum", pl ")"],
          [c "map", pl " applies a block that takes the ", c "Range Fixnum", pl " and returns an ", c "Array Fixnum"],
          [c "select", pl ", with its block, takes an ", c "Array Fixnum", pl " and returns an ", c "Array Fixnum"],
          [pl "Finally, ", c "count", pl " is simply applied to the ", c "Array Fixnum"]
        ]
      ]
    ],
    Section "Message passing (OOP style) can be achieved via closures" [
      Text [
        pl "Disclaimer/pl: this last \"Aha\" is shamelessly ripped off from ",
        "The Structure and Interpretation of Computer Programs" ->> "https://mitpress.mit.edu/sicp/full-text/book/book.html",
        pl " (SICP). I am over half way through this book, it is wonderful, please consider showing the authors your support by buying it."
      ],
      Text [
        pl "The authors of SICP take the reader through a fantastic journey in which the powers of LISP and functional programming are clearly displayed through examples in the Scheme dialect. One piece of this journey that recently blew my mind was when the authors used closures to define a mutable bank account that responds to different messages. Here's the code ",
        "(again shamelessly ripped)" ->> "https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-20.html#%_sec_3.1.1"
      ],
      Img (Just 80) "fp_aha_5.png",
      Text [
        pl "What you're seeing here is basically a constructor that builds objects, given a beginning balance, that respond to the ",
        c "'withdraw",
        pl " and ",
        c "'deposit",
        pl " messages."
      ],
      Text [
        pl "Frankly, I don't really know what I can say about this that the authors haven't already said (1) more articulately, (2) more clearly and (3) in a more inspirational manner."
      ],
      Text [
        pl "In conclusion, these are just a few of the awesome concepts I've picked up in my pursuit of functional programming. If you have any thoughts on these, or my description of them, don't hesitate to comment."
      ]
    ]
  ]
