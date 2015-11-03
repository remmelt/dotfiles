#! /bin/sh

files="zshrc gitconfig vimrc"

for file in $files; do
  ln -s "$PWD"/$file ~/.$file
done

# Set up Vundle and install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
