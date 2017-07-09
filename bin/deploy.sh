#!/bin/bash

# Run this script to deploy the app to Github Pages.

# Exit if any subcommand fails.
set -e

echo "Started deploying"

# Build site.
bower install
bundle exec jekyll build

# Delete and move files.
find . -maxdepth 1 ! -name '_site' ! -name '.git' ! -name '.gitignore' -exec rm -rf {} \;

# go to the out directory and create a *new* Git repo
cd _site
git init

# inside this git repo we'll pretend to be a new user
git config user.name "mskims"
git config user.email "its@mskim.me"

# Push to gh-pages.
git add .
git commit --allow-empty -m "Deploy to gh-pages [ci skip]"

git push --force --quiet "https://${GITHUB_TOKEN}@github.com/mskims/blog.git" master:gh-pages

echo "Deployed Successfully!"
