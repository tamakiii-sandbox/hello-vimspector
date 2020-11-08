.PHONY: help setup dependencies install build clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies \
	deps/vim \
	deps/vim-plug

dependencies:
	type vim > /dev/null
	type curl > /dev/null
	type git > /dev/null

install: \
	~/.vimrc \
	~/.vim/autoload/plug.vim \
	~/.vim/plugged

build: \
	a.out

a.out: src/main.c
	gcc -g $<

deps/vim: deps
	git clone --depth=1 git@github.com:vim/vim.git $@

deps/vim-plug: deps
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

deps:
	[ -d $@ ] || mkdir $@

~/.vimrc: .vimrc
	ln -sfnv $(realpath $<) $@

~/.vim/autoload/plug.vim: deps/vim-plug ~/.vim/autoload
	ln -sfnv $(realpath $<) $@

~/.vim/plugged:
	vim -c 'PlugInstall!' -c 'qa!'

~/.vim/plugged/vimspector/gadgets/linux/vscode-cpptools:
	vim -c 'VimspectorInstall!' -c 'qa!'

~/.vim/plugged/vimspector/gadgets/linux/CodeLLDB:
	vim -c 'VimspectorInstall!' -c 'qa!'

~/.vim/autoload: ~/.vim
	[ -d $@ ] || mkdir -p $@

~/.vim:
	[ -d $@ ] || mkdir -p $@

clean:
	rm -rf ~/.vimrc
	rm -rf ~/.vim/autoload/plug.vim
	rm -rf ~/.vim/plugged
