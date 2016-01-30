#!/bin/bash

elm make Main.elm \
	 Header.elm \
	 Blog.elm \
	 About.elm \
	 CommonStyles.elm \
	 Footer.elm \
	 Post.elm --output=index.html
