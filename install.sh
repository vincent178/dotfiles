#!/bin/bash

# Install vundle 
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Clone Repo
cd ~
git clone https://github.com/vincent178/dotfiles.git 


# copy all dotfiles
for file in `find dotfiles | grep "dotfiles/[a-zA-Z]*/\."`; do
	ln -nfs ${file} ~/.${basename}
done

echo "**************************************************"
echo "*********  All files done! Enjoy *****************"
echo "**************************************************"
