if [ -z "$SYSTEM_PATH" ]; then
  export SYSTEM_PATH="$PATH"
fi

export EDITOR='vim'

if [ -d ~/bin ]; then
  PATH="$HOME/bin:$PATH"
fi

if [ -n "$PS1" ]; then
  if [ -r ~/.bashrc ]; then
    source ~/.bashrc
  fi
fi
