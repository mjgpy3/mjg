module Posts.IntroducingMappy (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "Introducing Mappy" [HaskellTag, LispTag, FPTag, ProgrammingTag, MappyTag] (2016, 1, 31) [
    Text [
      Plain "During my nice little break last week I figured, why not? I'll make my toy programing language more real! The result is",
      Link
        "a functional programming language that is similar to Lisp, except maps (aka dictionaries, aka HashMaps, aka Hashes) are the core primitive"
        "https://github.com/PolyglotSymposium/mappy",
      Plain ", not lists."
    ],
    Text [
      Plain "You're probably thinking to yourself, \"what's the point in yet another Lisp-like language?\" Well, that's a great question! Mappy's really a breakable toy for my amusement (i.e. in its current state, Mappy's definitely not ready for production). That being said, here are some interesting design choices in the language",
      BulletedList
        [
          [Plain "I decided to go with maps rather than lists, because maps are more closely related to functions"],
          [Plain "Keeping expressions simple and singular (a la Lisp) makes parsing and grammar rules trivial"],
          [Plain "(Bias alert) Haskell is an amazing language in which to implement compilers"],
          [Plain "I didn't want to implement ", InlineCode "if", Plain " as a core primitive, so I had to choose between non-strictness and auto-closure function arguments (the latter won for simplicity reasons)"],
          [Plain "Parsec and QuickCheck can really save you when you're trying to keep complex rules consistent (e.g. parsing)"],
          [Plain "Github issues and milestones are an excellent way to break a problem into small chunks and really focus"],
          [Plain "Implementing IO as a map has had constraining effects (no pun intended) that are similar to the IO monad"]
        ],
      Plain "If you're curious what the language looks like, I'd check out the",
      Link
        "work in progress prelude (standard library)"
        "https://github.com/PolyglotSymposium/mappy/blob/master/prelude/prelude.map",
      Plain "otherwise, here's a taste of the language"
    ],
    Code MappyLanguage """filter p? xs = [
  if [empty? xs]
    nil
    let
      first = [take :head xs]
      rest = [take :tail xs]
    in [if [p? first]
         [cons first [filter p? rest]]
         [filter p? rest]]
]
""",
    Text [
      Plain "If you're interested in contributing, have a peek at the",
      Link
        "issues"
        "https://github.com/PolyglotSymposium/mappy/issues",
      Plain "or feel free to play with it, see the README, and/or file some issues!"
    ]
  ]
