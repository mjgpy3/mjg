#!/bin/bash

POSTS=`find Posts -name "*.idr"`

echo $POSTS

idris -p effects -o gen_blog Post.idr $POSTS Main.idr
