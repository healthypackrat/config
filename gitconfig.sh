#!/bin/sh

gitconfig () {
  git config --global "$@"
}

gitconfig core.excludesFile ~/.gitignore_global

gitconfig color.ui auto

gitconfig alias.b branch
gitconfig alias.ci commit
gitconfig alias.co checkout
gitconfig alias.ds 'diff --cached'
gitconfig alias.ld "log --format=tformat:'%h [%aD] %s'"
gitconfig alias.ln 'log --name-status'
gitconfig alias.lp 'log -p'
gitconfig alias.lso 'ls-files -o'
gitconfig alias.st status
