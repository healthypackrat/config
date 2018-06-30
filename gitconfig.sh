#!/bin/sh

gitconfig () {
  git config --global "$@"
}

gitconfig core.excludesFile ~/.gitignore_global

gitconfig color.ui auto

gitconfig alias.b branch
gitconfig alias.ci commit
gitconfig alias.co checkout
gitconfig alias.st status
