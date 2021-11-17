#! /bin/sh

files="gitconfig gitignore_global vimrc zshrc bin p10k.zsh zsh_options"

for file in $files; do
  ln -s "$PWD"/$file ~/.$file
done

