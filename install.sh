#!/bin/bash

# Install vundle 
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# copy all dotfiles
for file in `find . | grep "\./[a-zA-Z]*/\."`; do
  echo ${file}
  cp ${file} ~/
done

echo "**************************************************"
echo "*********  All files done! Enjoy *****************"
echo "**************************************************"
