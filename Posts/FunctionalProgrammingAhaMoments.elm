module Posts.FunctionalProgrammingAhaMoments (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "Functional Programming Aha! Moments" [ClojureTag, FPTag, HaskellTag, LispTag, MonadTag, SICPTag, SchemeTag] (2015, 5, 19) [
    Text [
      Plain "In the past couple of years, I've dedicated a fair amount of time to closet-functional-programming. Although I haven't gotten an opportunity to use a more purist functional programming language (e.g. not Framework_of_the_day.JS) in my day-to-day day, industry work, I believe some of the values of functional programming have bled into my daily practice, for the better."
    ],
    Text [
      Plain "Industry aside, I want to share some of the \"Aha! moments\" I've had while learning about functional programming. These are moments where something just clicked for me; some part of me almost can't help but share them."
    ],
    Section "Lets can be described by anonymous functions" [
      Text [
        Plain "Although \"functional programming\" is one of those things were if you ask five people for a definition you are likely to get six different definitions, one general consensus seems to hold: assignment should be reduced, minimally scoped or eliminated entirely in functional programming."
      ],
      Text [
        Plain "The let macro/expression/sugar is basically a means of reducing assignments into minimally scoped, (generally) non-mutative expressions with a set of bindings. Here's a contrived example of what this might look like in Clojure"
      ],
      Img (Just 40) "fp_aha_1.png",
      Text [
        Plain "Here we're saying, let's bind ",
        InlineCode "x",
        Plain " to ",
        InlineCode "35",
        Plain " then ",
        InlineCode "y",
        Plain " to a value calculated from ",
        InlineCode "x",
        Plain ", then we'll use ",
        InlineCode "y",
        Plain " to calculate some result. This entire expression is just that, it's an expression. This ",
        InlineCode "let",
        Plain " is evaluated as a whole, and the result is simply ",
        InlineCode "42",
        Plain "."
      ],
      Text [
        Plain "So, here comes the first \"Aha!\" This same kind of scoped assignment can be done through applying anonymous functions! Here's what that looks like for the above example"
      ],
      Img (Just 40) "fp_aha_2.png",
      Text [
        Plain "Basically the pattern here is just, for each bound symbol (in this case ",
        InlineCode "x",
        Plain " and ",
        InlineCode "y",
        Plain ") nest and call an anonymous function, passing the bound value down (",
        InlineCode "35",
        Plain " and ",
        InlineCode "(- x 14)",
        Plain ")! I found this discovery exceptionally cool because it further emphasized the power of these functional languages: something as simple as anonymous functions can be combined to form powerful abstractions. "
      ]
    ],
    Section "Monadic bind is like method chaining" [
      Text [
        Plain "Monads, in general, have provided many an \"Aha\" for me. They're definitely one of those constructs where, once you get passed the initial \"this is slightly out of my comfort zone\" feeling, you are ready to embrace an overwhelming amount of power.",
        InlineCode "bind",
        Plain "(symbolically ",
        InlineCode ">>=",
        Plain ") is one of the crucial operations implementable by a monad, it has the following type signature"
      ],
      Img (Just 40) "fp_aha_3.png",
      Text [
        Plain "Ignoring currying and some other subtleties, if I'm thinking in an \"object oriented mindset\" I might reason about this as follows",
        BulletedList [
          [ InlineCode "bind"
          , Plain " is a function that take 2 arguments"
          , BulletedList [
             [ Plain "a generic wrapper around some type ", InlineCode "a" ],
             [ Plain "a function which takes some ", InlineCode "a", Plain "and returns some generic wrapper around type ", InlineCode "b", Plain " (where ", InlineCode "b", Plain " may be the same type as ", InlineCode "a", Plain ")" ]
            ]
          ],
          [ InlineCode "bind", Plain " returns some generic wrapper around type ", InlineCode "b" ]
        ]
      ],
      Text [
        Plain "To me, this sounds exactly like a single call that enables method chaining! Think a la calling ",
        InlineCode "bind",
        Plain " to transform from monad to monad to monad... In my mind, ",
        InlineCode "bind",
        Plain " is an enabling feature, that allows Haskell code to be elegant, expressive and powerful without lacking type safety (see ",
        Link
          "do-notation"
          "http://en.wikibooks.org/wiki/Haskell/do_notation",
        Plain ")."
      ],
      Text [
        Plain "To visualize how this is kind of like method chaining, observe the following Ruby code"
      ],
      Img (Just 40) "fp_aha_4.png",
      Text [
        Plain "We can imagine these calls (with the exception of ",
        InlineCode "count",
        Plain ") being like a type-not-so-safe version of Haskell's ",
        InlineCode "bind",
        Plain " applied a couple of times (2 to be exact). Here are what the steps might look like",
        NumberedList [
          [InlineCode "m a", Plain " is a range of ", InlineCode "Fixnum", Plain " (e.g. ", InlineCode "Range Fixnum", Plain ")"],
          [InlineCode "map", Plain " applies a block that takes the ", InlineCode "Range Fixnum", Plain " and returns an ", InlineCode "Array Fixnum"],
          [InlineCode "select", Plain ", with its block, takes an ", InlineCode "Array Fixnum", Plain " and returns an ", InlineCode "Array Fixnum"],
          [Plain "Finally, ", InlineCode "count", Plain " is simply applied to the ", InlineCode "Array Fixnum"]
        ]
      ]
    ],
    Section "Message passing (OOP style) can be achieved via closures" [
      Text [
        Plain "Disclaimer/Plug: this last \"Aha\" is shamelessly ripped off from",
        Link
          "The Structure and Interpretation of Computer Programs"
          "https://mitpress.mit.edu/sicp/full-text/book/book.html",
        Plain "(SICP). I am over half way through this book, it is wonderful, please consider showing the authors your support by buying it."
      ],
      Text [
        Plain "The authors of SICP take the reader through a fantastic journey in which the powers of LISP and functional programming are clearly displayed through examples in the Scheme dialect. One piece of this journey that recently blew my mind was when the authors used closures to define a mutable bank account that responds to different messages. Here's the code ",
        Link
          "(again shamelessly ripped)"
          "https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-20.html#%_sec_3.1.1"
      ],
      Img (Just 40) "fp_aha_5.png",
      Text [
        Plain "What you're seeing here is basically a constructor that builds objects, given a beginning balance, that respond to the ",
        InlineCode "'withdraw",
        Plain " and ",
        InlineCode "'deposit",
        Plain " messages."
      ],
      Text [
        Plain "Frankly, I don't really know what I can say about this that the authors haven't already said (1) more articulately, (2) more clearly and (3) in a more inspirational manner."
      ],
      Text [
        Plain "In conclusion, these are just a few of the awesome concepts I've picked up in my pursuit of functional programming. If you have any thoughts on these, or my description of them, don't hesitate to comment."
      ]
    ]
  ]
