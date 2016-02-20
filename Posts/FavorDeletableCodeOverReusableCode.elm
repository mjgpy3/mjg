module Posts.FavorDeletableCodeOverReusableCode (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "Favor Deletable Code Over Reusable Code" [DeletingCodeTag, ProgrammingTag, SoftwareEngineeringTag] (2015, 6, 28) [
    Text [
      pl "As problem solvers who work primarily in the medium of software, we're sold reusability throughout our careers (and even, likely, in our educations). We're told that if we just think ahead, if we put forth more effort, we can jump to a new plane of abstraction and achieve a solution that will be usable in the future to more quickly and easily solve a similar problem. Although this sounds pretty awesome in theory, I don't buy it in practice."
    ],
    Section "Arguments against optimizing for reuse" [
      Text [
        pl "The first real problem I have with premature abstraction (in the hope of reuse) is just that -- it's premature. We'd like to think we know how our system ought to flex in the future, but we just don't. We're not fortune tellers."
      ],
      Text [
        pl "We mean well. We build a more general solution than needed to solve a real problem"
      ],
      Img Nothing "favor_delete_1.png",
      Text [
        pl "Our hope, thinking and intention is that future, similar problems will fit nicely into our \"framework\""
      ],
      Img (Just 60) "favor_delete_2.png",
      Text [
        pl "This sounds great, but there's a lot that can go wrong."
      ],
      Text [
        pl "Firstly, what happens if our expanded solution doesn't \"fully\" solve the problem at hand?"
      ],
      Img (Just 60) "favor_delete_2.png",
      Text [
        pl "Do we rewrite our more general solution to accommodate the actual problem? I find, generally, we don't. Instead we extend and further abstract our large solution to make it encompass the areas we missed. If we do re-write the general solution entirely, the previous general solution was effectively a time sink."
      ],
      Text [
        pl "There's a fair amount of regression headache here as well. If I decided to extend my prior abstraction, then I have to do without breaking the parts that partially solved the problem to begin with. Also, assuming I still believed parts of the original abstraction to be valuable to future solutions, I would be required to also keep those from breaking."
      ],
      Text [
        pl "Secondly, there's a question I try to ask myself before I solve future problems: ",
        Emph "what will happen if this problem is a one-off?",
        pl " I usually have a few different answers to this",
        BulletedList [
          [pl "I will have wasted time building abstractions and tests that weren't actually needed"],
          [pl "I will have obfuscated the intent of the solution with unnecessary abstraction, forcing future maintainers (myself included) to understand a more general problem than the one actually being solved, and"],
          [pl "I will have introduced more actual code and tests to maintain (in many codebases this may be a drop in a bucket, but still, more is more)"]
        ]
      ],
      Text [
        pl "The third and final consideration I have before thinking about reuse is really a few tightly-related questions, pertaining to reuse itself",
        NumberedList [
          [pl "If a future problem is solvable by my abstraction, how will developers know to use it?"],
          [pl "If a future problem looks like it's solved by my abstraction, but it's actually a different problem, how will other developers know not to use my abstraction?"],
          [pl "What happens when a future problem is 90% solved by my abstraction? Is it flexible enough that someone else will be able to extend it to fit that extra 10%, while maintaining its integrity?"]
        ]
      ],
      Text [
        pl "In my fairly short exposure to professional software development, I find the answers are something along the lines of",
        NumberedList [
          [pl "They won't. They'll build another solution, and maybe their own abstraction framework to some degree."],
          [pl "See 1, they probably won't ever see my abstraction or understand it. Although, I have seen a good bit of the \"copy the original source, and tweak to fit\" pattern applied in response to this question"],
          [pl "It won't be flexible enough. They'll build another solution."]
        ]
      ],
      Text [
        pl "Like I said, I'm a novice developer. So if you have solutions to these questions and problems, I'm eager to hear them!"
      ]
    ],
    Section "Deletable code" [
      Text [
        pl "Alright, honesty time. The above words are truly my take on some points made in ",
          "Greg Young's the art of destroying software talk" ->>
          "https://vimeo.com/108441214",
        pl ". At this point, I could spend paragraphs describing the value obtained by having code that, by nature, is easy to delete. But, to do so would be a waste of time when Greg has so well articulated the points. So, with that, I urge you to watch the linked talk, and rip my arguments to shreds in the comments section."
      ]
    ]
  ]
