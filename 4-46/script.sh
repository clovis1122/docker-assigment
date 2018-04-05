#!/bin/sh

# This script is for the assigment found at section 4, lecture 46.

# Start the container first. We'll bind mount the actual directory into the /site directory.
# NOTE: bretfisher/jekyll-serve is a custom image.
# NOTE #2: Assuming we're in the bind-mount-1 directory.

docker run -d -p 80:4000 -v $(pwd):/site bretfisher/jekyll-serve

# Then make changes! We'll use nano for this.

nano _posts/2017-03-05-welcome-to-jekyll.markdown

# When done, refresh the page (localhost). Changes should appear after refreshing.
