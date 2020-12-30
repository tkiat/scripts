#!/usr/bin/env bash
# coding
guix install \
	font-gnu-freefont \
	guile \
	node \
	python \

# general (net-tools for ifconfig)
guix install \
	acpi \
	curl \
	file \
	git \
	gnupg \
	htop \
	neofetch \
	net-tools \
	password-store \
	pv \
	redshift \
	wget \
	zsh \

# file & browser (tumbler to enable preview in thunar)
guix install \
	mc \
	ntfs-3g \
	qutebrowser \
	ranger \
	rsync \
	thunar \
	tumbler \
	tree \

# multimedia
guix install \
	cmus \
	jpegoptim \
	pngquant \
	scrot \
	vlc \

# office
guix install \
	feh \
	ghostscript \
	vim-full \
	xpdf \

# xorg
guix install \
	setxkbmap \
