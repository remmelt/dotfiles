#! /bin/sh

files="zshrc"

for file in $files; do
  ln -s "$PWD"/$file ~/.$file
done
