module Posts.FavorDeletableCodeOverReusableCode (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "Favor Deletable Code Over Reusable Code" [DeletingCodeTag, ProgrammingTag, SoftwareEngineeringTag] (2015, 6, 28) [
    Text [
      Plain "As problem solvers who work primarily in the medium of software, we're sold reusability throughout our careers (and even, likely, in our educations). We're told that if we just think ahead, if we put forth more effort, we can jump to a new plane of abstraction and achieve a solution that will be usable in the future to more quickly and easily solve a similar problem. Although this sounds pretty awesome in theory, I don't buy it in practice."
    ],
    Section "Arguments against optimizing for reuse" [
      Text [
        Plain "The first real problem I have with premature abstraction (in the hope of reuse) is just that -- it's premature. We'd like to think we know how our system ought to flex in the future, but we just don't. We're not fortune tellers."
      ],
      Text [
        Plain "We mean well. We build a more general solution than needed to solve a real problem"
      ],
      Img "favor_delete_1.png"
    ]
  ]
