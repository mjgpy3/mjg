module Posts.TrieInHaskell (post) where

import Post exposing (..)
import Html

post : Post
post =
  BlogPost "Trie in Haskell" [DSATag, FPTag, HaskellTag, ProgrammingTag] (2015, 10, 25) [
    Text [
      pl "Lately I've been playing around with Haskell. As an exercise, I decided to partially implement a Trie. I ignored the various implementations out there, including ",
      "Data.Trie" ->> "https://hackage.haskell.org/package/bytestring-trie-0.2.4.1/docs/Data-Trie.html",
      pl " and the one linked on Wikipedia. Instead I focused on iterating on a Trie from scratch, and I found the results to be pretty interesting, so I'm sharing them here."
    ],
    Text [
      pl "My real goal with this exercise was to implement ",
      c "member",
      pl ", ",
      c "insert",
      pl " and a sorted ",
      c "toList",
      pl ". This interface turns out to be more similar to a Set than say a Map, because there aren't values associated with members. I used ",
      c "[a]",
      pl " to represent a member of the ",
      c "Trie a",
      pl " which, in retrospect, looks like a ",
      "Monoid" ->> "https://en.wikibooks.org/wiki/Haskell/Monoids",
      pl ". Well, anyways, my first structure came out looking like"
    ],
    Code HaskellLanguage """data Trie a =
  RootNode [TrieNode a]
  deriving Show

data TrieNode a =
  Leaf a
  | SpineEnd a [TrieNode a]
  | Spine a [TrieNode a]
  deriving Show
""",
    Text [
      pl "In this modeling, ",
      c "Leaf a",
      pl " indicated the end of a member at a leaf, ",
      c "SpineEnd a [TrieNode a]",
      pl " indicated an end on a spine, ",
      c "Spine a [TrieNode a]",
      pl " was a non-ending spine, and well ",
      c "RootNode [TrieNode a]",
      pl " indicated the root. At first glance, I really liked this model. After implementing the Trie, however, I found the structure less than desirable for a few reasons",
      BulletedList [
        [pl "Since \"edges\" are a list, a fair amount of boilerplate traversal code was necessary to implement the operations"],
        [ pl "Although at first I liked keeping "
        , c "RootNode"
        , pl "separate, but later I realized it was inhibiting me from inserting the empty list"
        ],
        [ pl "Turns out that "
        , c "Leaf a"
        , pl " is totally redundant with "
        , c "SpineEnd a []"
        ]
      ],
      pl "I'm much more pleased with the second structure I came up with"
    ],
    Code HaskellLanguage """import qualified Data.Map as M

type TrieEdges a = M.Map a (Trie a)

data Trie a =
  Node { edges :: TrieEdges a }
  | EndNode { edges :: TrieEdges a }
  deriving (Show, Eq)

empty :: Trie a
empty = Node M.empty
""",
    Text [
      pl "Not only does this design have fewer parts than the other, but it yielded a simpler implementation. Here's the code for ",
      c "insert"
    ],
    Code HaskellLanguage """insert :: Ord a => [a] -> Trie a -> Trie a
insert [] n = EndNode $ edges n
insert vs (Node m) = Node $ insertBelow vs m
insert vs (EndNode m) = EndNode $ insertBelow vs m

insertBelow (v:vs) m = M.insert v (insert vs child) m
  where child = M.findWithDefault empty v m
""",
    Text [
      pl "I believe it's pretty straightforward. The only real tricks were safely creating edges where none existed (which is the main purpose of ",
      c "insertBelow",
      pl ") and ensuring that the node at the end of a member is an ",
      c "EndNode",
      pl ". The ",
      c "member",
      pl " function turned out even nicer"
    ],
    Code HaskellLanguage """member :: Ord a => [a] -> Trie a -> Bool
member [] (EndNode _) = True
member [] (Node _) = False
member (v:vs) n = maybe False (member vs) . M.lookup v $ edges n
""",
    Text [
      pl "Getting an in-order ",
      c "toList",
      pl " was a little bit tricker but, thanks to the useful functions in ",
      c "Data.Map",
      pl " it was quite doable"
    ],
    Code HaskellLanguage """toList :: Trie a -> [[a]]
toList = go []
  where
  go acc (Node m) = continue acc m
  go acc (EndNode m) = reverse acc:continue acc m

  accumulating acc v n = go (v:acc) n
 
  continue acc = concatMap (accumulating acc) . M.toList
""",
    Text [
      pl "In conclusion, if you have any comments, improvements or tips to make this better let me know!"
    ]
  ]
