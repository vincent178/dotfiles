#!/bin/bash

# Install vundle 
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Clone Repo
cd ~
git clone https://github.com/vincent178/dotfiles.git 


# copy all dotfiles
cd ~/dotfiles
for file in `find . | grep "\./[a-zA-Z]*/\."`; do
  basename = ${file##*/}
  ln -nfs ${file} ~/.${basename}
done
cd ~

echo "**************************************************"
echo "*********  All files done! Enjoy *****************"
echo "**************************************************"
