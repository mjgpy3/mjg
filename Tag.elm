module Tag where

type Tag =
  Clojure
  | Haskell
  | Lisp
  | Mappy
  | FP
  | OOP
  | Programming
  | SoftwareEngineering
  | DeletingCode
  | Idris
  | DSA
  | Scheme
  | Monad
  | SICP
  | Ruby

type alias Tags = List Tag

tagToString : Tag -> String
tagToString tag = case tag of
  Programming -> "programming"
  Clojure -> "clojure"
  Haskell -> "haskell"
  Lisp -> "lisp"
  Mappy -> "mappy"
  FP -> "functional_programming"
  OOP -> "object_oriented_programming"
  Idris -> "idris"
  DSA -> "data_structures_and_algorithms"
  SICP -> "struct_and_interp_of_computer_programs"
  Ruby -> "ruby"
  SoftwareEngineering -> "software_engineering"
  DeletingCode -> "deleting_code"
  Scheme -> "scheme"
  Monad -> "monad"
