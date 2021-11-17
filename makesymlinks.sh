#! /bin/sh

files="gitconfig vimrc zshrc bin p10k.zsh zsh_options"

for file in $files; do
  ln -s "$PWD"/$file ~/.$file
done

