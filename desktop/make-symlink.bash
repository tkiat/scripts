#!/bin/bash
dotfiles_dir=~/Git/dotfiles/dotfiles
# .asoundrc
# [ ! -f ~/.asoundrc ] && ln -s $dotfiles_dir/.asoundrc ~/.asoundrc
# .tmux.conf
[ ! -f ~/.tmux.conf ] && ln -s $dotfiles_dir/.tmux.conf ~/.tmux.conf
# .vim
[ ! -f ~/.vimrc.shared ] && ln -s $dotfiles_dir/.vimrc.shared ~/.vimrc.shared
[ ! -f ~/.vimrc ] && echo 'source $HOME/.vimrc.shared"' > ~/.vimrc

[ ! -d ~/.vim/colors ] && mkdir -p ~/.vim/colors
[ ! -f ~/.vim/colors/tkiat.vim ] && ln -s $dotfiles_dir/.vim/colors/tkiat.vim ~/.vim/colors/tkiat.vim

[ ! -d ~/.vim/template ] && mkdir -p ~/.vim/template
for file in $dotfiles_dir/.vim/template/*; do [ ! -f ~/.vim/template/$(basename $file) ] && ln -s $file ~/.vim/template/$(basename $file); done
# .zshenv
[ ! -f ~/.zshenv ] && ln -s $dotfiles_dir/.zshenv.shared ~/.zshenv.shared
[ ! -f ~/.zshenv ] && echo "source ~/.zshenv.shared" > ~/.zshenv
# .zshrc
[ ! -f ~/.zshrc ] && ln -s $dotfiles_dir/.zshrc.shared ~/.zshrc.shared
[ ! -f ~/.zshrc ] && echo "source ~/.zshrc.shared" > ~/.zshrc

