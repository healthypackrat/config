alias ..='cd ..'

alias j='jobs'

alias ls='ls -FG'

alias l='ls -A'
alias ll='l -l'

alias be='bundle exec'

alias st='git status'

alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

alias gemcd='cd $(ruby -e "puts Dir[%(#{Gem.dir}/gems/*)].sort" | peco)'

if which terminal-notifier-alert > /dev/null 2>&1; then
  alias alert='terminal-notifier-alert $? "$(history | tail -1)"'
fi

if which brew > /dev/null 2>&1; then
  if [ -r "$(brew --prefix)"/etc/bash_completion ]; then
    source "$(brew --prefix)"/etc/bash_completion
  fi

  if [ -r "$(brew --prefix)"/etc/bash_completion.d/git-prompt.sh ]; then
    source "$(brew --prefix)"/etc/bash_completion.d/git-prompt.sh
    PS1='[\u@\h:\W$(__git_ps1 " (%s)")]\$ '
  fi
fi

if which nodenv > /dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

if which pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if which rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if which stack > /dev/null 2>&1; then
  eval "$(stack --bash-completion-script stack)"
fi
