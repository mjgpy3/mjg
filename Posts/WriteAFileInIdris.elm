module Posts.WriteAFileInIdris (post) where

import Post exposing (..)
import Html

import Tag

post : Post.Post
post = write_a_file_in_idris

write_a_file_in_idris : Post
write_a_file_in_idris =
  BlogPost "Write a File in Idris" [Tag.FP, Tag.Idris, Tag.Programming] (2015, 11, 15) [
    Text [
      pl "Although Idris' documentation seems better than 99% of opensource projects out there, I couldn't easily find the steps necessary to write a file. After recalling that ",
      "Brian McKenna wrote his blog in Idris" ->> "http://brianmckenna.org/blog/idris_blog",
      pl " I figured he would have a nice example of how to write a file and I was right! This post is heavily ripped from his work. The actual code (taken from the ",
      "Main file" ->> "https://github.com/puffnfresh/bam-idris-blog/blob/master/Main.idr#L48-L53",
      pl " of Brain's code generator) looks like"
    ],
    Code IdrisLanguage """writeFile : String -> String -> IO ()
writeFile f s = do
  f <- openFile f Write
  fwrite f s
  closeFile f
""",
    Text [
      pl "Pretty straight forward. It takes a file name and the content to write, opens a handle, writes the contents to that file then closes it. Now, I had found and written code like this in Idris' docs, but couldn't get it to compile. The trick was to tell Idris to compile and include the ",
      c "effects",
      pl " package, like so"
    ],
    Code BashLanguage "idris -p effects Main.idr -o my_program",
    Text [
      pl "Thanks Brian!"
    ]
  ]
