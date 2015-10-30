module Main

data TitleBarItem = BarItem String
data LinkRollItem = LinkItem String String

data Component =
  TitleBar (List TitleBarItem)
  | LinkRoll (List LinkRollItem)

data Node =
  Section (Maybe String) (List Node)
  | Comp Component

template : Node -> Node
template content = Section Nothing [
  Section (Just "Michael Gilliland's Site") [
    Comp $ TitleBar [BarItem "About Me", BarItem "Blog"],
    content,
    Comp $ LinkRoll []
  ]
]

data Html =
  Tag String (List (String, String)) (Either (List Html) (Maybe String))

aTag : String -> String -> Html
aTag href text = Tag "a" [
  ("class", "button-large pure-button pure-button-primary"),
  ("href", href)
  ] $ Right $ Just text

htmlToString : Html -> String
htmlToString (Tag name xs (Left y)) = "<" ++ name ++ ">" ++ "</" ++ name ++ ">"
htmlToString (Tag name xs (Right Nothing)) = ?htmlToString_rhs_2
htmlToString (Tag name xs (Right (Just y))) = ?htmlToString_rhs_4

toHtml : Node -> String
toHtml (Section Nothing xs) = ?toHtml_rhs_2
toHtml (Section (Just x) xs) = ?toHtml_rhs_3
toHtml (Comp (TitleBar xs)) = ?toHtml_rhs_1
toHtml (Comp (LinkRoll xs)) = ?toHtml_rhs_5

main : IO ()
main = print "Hello there!"
