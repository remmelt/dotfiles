#! /bin/sh

files="gitconfig vimrc zshrc bin p10k.zsh"

for file in $files; do
  ln -s "$PWD"/$file ~/.$file
done

brew bundle
