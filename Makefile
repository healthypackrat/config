prefix = $(HOME)

sources = \
  dot.bash_profile \
  dot.bashrc \
  dot.ctags.d/common.ctags \
  dot.ctags.d/ruby.ctags \
  dot.gemrc \
  dot.gitignore_global \
  dot.inputrc \
  dot.irbrc \
  dot.tmux.conf \
  dot.vim/after/ftplugin/c/path.vim \
  dot.vim/after/ftplugin/ruby/path.vim \
  dot.vim/ftdetect/ruby.vim \
  dot.vim/ftdetect/vue.vim \
  dot.vimrc

targets = $(patsubst dot.%,$(prefix)/.%,$(sources))

targets += $(prefix)/.gitconfig

.PHONY: all show-diff

all: $(targets)

$(prefix)/.gitconfig: gitconfig.sh
	./gitconfig.sh

$(prefix)/.%: dot.%
	@ test -d '$(dir $@)' || mkdir -p '$(dir $@)'
	cp $< $@

show-diff:
	@ for source in $(sources); do \
	    diff -u "$(prefix)/.$${source#dot.}" "$$source"; \
	  done; true
