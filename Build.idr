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

a : String -> String -> Html
a href text = Tag "a" [
  ("class", "button-large pure-button pure-button-primary"),
  ("href", href)
  ] $ Right $ Just text

h : String -> Int -> Html
h text level = Tag ("h" ++ show level) [] (Right $ Just text)

attributesToString : List (String, String) -> String
attributesToString = foldr (\(attr, value), r => r ++ concat [attr, "=\"", value, "\" "]) ""

tagify : String -> List (String, String) -> String -> String
tagify tagName attrs content =
  concat ["<", tagName, " ", attributesToString attrs, ">", content, "</", tagName, ">"]

htmlToString : Html -> String
htmlToString (Tag name attrs (Left children)) = tagify name attrs $ concatMap htmlToString children
htmlToString (Tag name attrs (Right Nothing)) = tagify name attrs ""
htmlToString (Tag name attrs (Right (Just content))) = tagify name attrs content

record TranlationST where
  constructor MkTranlationST
  level : Int

initialState : TranlationST
initialState = MkTranlationST 1

componentToHtml : TranlationST -> Component -> Html
componentToHtml x (TitleBar xs) = ?componentToHtml_rhs_1
componentToHtml x (LinkRoll xs) = ?componentToHtml_rhs_2

toHtml : Node -> Html
toHtml node = toHtml' initialState node
  where
    toHtml' : TranlationST -> Node -> Html
    toHtml' st (Section (Just header) xs) = Tag "div" [] $ Left $ h header (level st)::map (toHtml' st) xs
    toHtml' st (Section Nothing xs) = Tag "div" [] $ Left $ map (toHtml' st) xs
    toHtml' st (Comp component) = componentToHtml st component

main : IO ()
main = print "Hello there!"
