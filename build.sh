#!/bin/bash

elm make Main.elm \
	 Header.elm \
	 Blog.elm \
	 About.elm \
	 CommonStyles.elm \
	 Footer.elm \
	 Post.elm \
	 Posts/*.elm \
         Posts.elm --output=index.html
