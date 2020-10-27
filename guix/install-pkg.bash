#!/usr/bin/env bash
guix package -i \
	fontconfig \
	glibc-locales \
	nss-certs

# CLI
guix package -i \
	ansible \
	cmus \
	cmatrix \
	curl \
	feh \
	go-github-com-junegunn-fzf \
	gcc-toolchain \
	git \
	go \
	gpgme \
	graphviz \
	mc \
	mercurial \
	node \
	neofetch \
	python-pip \
	redshift \
	ruby \
	scrot \
	the-silver-searcher \
	vim-full \
	vlc \
	tree \
	wget \
	which \
	xpdf \
	zsh

# GUI
guix package -i \
	blender \
	gimp

# game
guix package -i \
	supertux \
	crawl \
	crawl-tiles
