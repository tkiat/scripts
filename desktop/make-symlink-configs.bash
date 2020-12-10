#!/usr/bin/env bash
configs_dir=~/Git/dotfiles/config
# cmus
[ ! -d ~/.config/cmus ] && mkdir -p ~/.config/cmus
[ ! -f ~/.config/cmus/rc ] && ln -s $configs_dir/cmus/rc ~/.config/cmus/rc
