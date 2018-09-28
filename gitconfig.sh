#!/bin/sh

gitconfig () {
  git config --global "$@"
}

gitconfig core.excludesFile ~/.gitignore_global

gitconfig color.ui auto

gitconfig alias.b branch
gitconfig alias.ci commit
gitconfig alias.co checkout
gitconfig alias.d diff
gitconfig alias.ds 'diff --cached'
gitconfig alias.l log
gitconfig alias.ld "log --format=tformat:'%h [%cD] %s'"
gitconfig alias.st status
