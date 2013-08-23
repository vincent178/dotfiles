#!/bin/bash

# Install vundle 
[ -d ~/.vim/bundle/vundle ] || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Clone Repo
cd ~
if [ -d ~/dotfiles ]; then
  cd dotfiles
  git pull origin master
else
  git clone https://github.com/vincent178/dotfiles.git
fi


# copy all dotfiles
for file in `find dotfiles | grep "dotfiles/[a-zA-Z]*/\."`; do
	ln -nfs ${file} ~/.${basename}
done

echo "**************************************************"
echo "*********  All files done! Enjoy *****************"
echo "**************************************************"
