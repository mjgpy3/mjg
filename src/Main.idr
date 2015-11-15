module Main

import Post
import Posts.Each

writeFile : String -> String -> IO ()
writeFile f s = do
  f <- openFile f Write
  fwrite f s
  closeFile f

main : IO ()
main = do
  let (fileName, content) = postToHtml object_oriented_clojure_example
  writeFile fileName content
