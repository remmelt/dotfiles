#! /bin/sh

files="zshrc"

for file in $files; do
  ln -s $file ~/.$file
done

source ~/.zshrc
