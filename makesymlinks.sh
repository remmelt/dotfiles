#! /bin/sh

files="zshrc gitconfig"

for file in $files; do
  ln -s "$PWD"/$file ~/.$file
done
