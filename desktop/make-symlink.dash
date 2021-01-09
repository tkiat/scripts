#!/usr/bin/env dash
dotfiles_dir=~/Git/dotfiles/dotfiles
private_dir=~/Git/private
# asoundrc
[ ! -f ~/.asoundrc ] && ln -s $dotfiles_dir/.asoundrc ~
# buku
[ ! -d ~/.local/share/buku ] && mkdir -p ~/.local/share/buku
[ ! -f ~/.local/share/buku/bookmarks.db ] && ln -s $private_dir/buku/bookmarks.db ~/.local/share/buku
# cmus
[ ! -d ~/.config/cmus ] && mkdir -p ~/.config/cmus
[ ! -f ~/.config/cmus/rc ] && ln -s $dotfiles_dir/.config/cmus/rc ~/.config/cmus
# gitconfig
[ ! -f ~/.gitconfig ] && ln -s $dotfiles_dir/.gitconfig ~
# mc
[ ! -d ~/.config/mc ] && mkdir -p ~/.config/mc
[ ! -f ~/.config/mc/hotlist ] && ln -s $dotfiles_dir/.config/mc/hotlist ~/.config/mc
[ ! -f ~/.config/mc/mc.ext ] && ln -s $dotfiles_dir/.config/mc/mc.ext ~/.config/mc
# newsboat
[ ! -d ~/.newsboat/ ] && mkdir ~/.newsboat
[ ! -f ~/.newsboat/config ] && ln -s $dotfiles_dir/.newsboat/config ~/.newsboat/config
[ ! -f ~/.newsboat/urls ] && ln -s $private_dir/newsboat/urls ~/.newsboat/urls
# ranger
[ ! -d ~/.config/ranger ] && mkdir -p ~/.config/ranger
[ ! -f ~/.config/ranger/rc.conf ] && ln -s $dotfiles_dir/.config/ranger/rc.conf ~/.config/ranger
# tmux
[ ! -f ~/.tmux.conf ] && ln -s $dotfiles_dir/.tmux.conf ~
# vim
[ ! -f ~/.vimrc.shared ] && ln -s $dotfiles_dir/.vimrc.shared ~
[ ! -f ~/.vimrc ] && echo 'source $HOME/.vimrc.shared"' > ~/.vimrc
[ ! -d ~/.vim/backup ] && mkdir -p ~/.vim/backup
[ ! -d ~/.vim/swap ] && mkdir -p ~/.vim/swap
[ ! -d ~/.vim/undo ] && mkdir -p ~/.vim/undo
[ ! -d ~/.vim/colors ] && mkdir -p ~/.vim/colors
[ ! -f ~/.vim/colors/tkiat.vim ] && ln -s $dotfiles_dir/.vim/colors/tkiat.vim ~/.vim/colors
[ ! -d ~/.vim/template ] && mkdir -p ~/.vim/template
for file in $dotfiles_dir/.vim/template/*; do [ ! -f ~/.vim/template/$(basename $file) ] && ln -s $file ~/.vim/template/$(basename $file); done
# w3m
[ ! -d ~/.w3m ] && mkdir ~/.w3m
[ ! -f ~/.w3m/keymap ] && ln -s $dotfiles_dir/.w3m/keymap ~/.w3m
# xpdfrc
[ ! -f ~/.xpdfrc ] && ln -s $dotfiles_dir/.xpdfrc ~
# zsh
[ ! -f ~/.zshenv.shared ] && ln -s $dotfiles_dir/.zshenv.shared ~
[ ! -f ~/.zshenv ] && echo "source ~/.zshenv.shared" > ~/.zshenv
[ ! -f ~/.zshrc.shared ] && ln -s $dotfiles_dir/.zshrc.shared ~
[ ! -f ~/.zshrc ] && echo "source ~/.zshrc.shared" > ~/.zshrc
