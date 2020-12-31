#!/usr/bin/env bash
dotfiles_dir=~/Git/dotfiles/dotfiles
# .config
## cmus
[ ! -d ~/.config/cmus ] && mkdir -p ~/.config/cmus
[ ! -f ~/.config/cmus/rc ] && ln -s $dotfiles_dir/.config/cmus/rc ~/.config/cmus
## mc
[ ! -d ~/.config/mc ] && mkdir -p ~/.config/mc
[ ! -f ~/.config/mc/hotlist ] && ln -s $dotfiles_dir/.config/mc/hotlist ~/.config/mc
[ ! -f ~/.config/mc/mc.ext ] && ln -s $dotfiles_dir/.config/mc/mc.ext ~/.config/mc
## ranger
[ ! -d ~/.config/ranger ] && mkdir -p ~/.config/ranger
[ ! -f ~/.config/ranger/rc.conf ] && ln -s $dotfiles_dir/.config/ranger/rc.conf ~/.config/ranger

# .asoundrc
[ ! -f ~/.asoundrc ] && ln -s $dotfiles_dir/.asoundrc ~
# .gitconfig
[ ! -f ~/.gitconfig ] && ln -s $dotfiles_dir/.gitconfig ~
# .tmux.conf
[ ! -f ~/.tmux.conf ] && ln -s $dotfiles_dir/.tmux.conf ~
# .vim
[ ! -f ~/.vimrc.shared ] && ln -s $dotfiles_dir/.vimrc.shared ~
[ ! -f ~/.vimrc ] && echo 'source $HOME/.vimrc.shared"' > ~/.vimrc

[ ! -d ~/.vim/backup ] && mkdir -p ~/.vim/backup
[ ! -d ~/.vim/swap ] && mkdir -p ~/.vim/swap
[ ! -d ~/.vim/undo ] && mkdir -p ~/.vim/undo

[ ! -d ~/.vim/colors ] && mkdir -p ~/.vim/colors
[ ! -f ~/.vim/colors/tkiat.vim ] && ln -s $dotfiles_dir/.vim/colors/tkiat.vim ~/.vim/colors

[ ! -d ~/.vim/template ] && mkdir -p ~/.vim/template
for file in $dotfiles_dir/.vim/template/*; do [ ! -f ~/.vim/template/$(basename $file) ] && ln -s $file ~/.vim/template/$(basename $file); done
# .xpdfrc
[ ! -f ~/.xpdfrc ] && ln -s $dotfiles_dir/.xpdfrc ~
# .zshenv
[ ! -f ~/.zshenv.shared ] && ln -s $dotfiles_dir/.zshenv.shared ~
[ ! -f ~/.zshenv ] && echo "source ~/.zshenv.shared" > ~/.zshenv
# .zshrc
[ ! -f ~/.zshrc.shared ] && ln -s $dotfiles_dir/.zshrc.shared ~
[ ! -f ~/.zshrc ] && echo "source ~/.zshrc.shared" > ~/.zshrc

