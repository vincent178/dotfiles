#!/bin/bash
 
for file in `find . | grep "\./[a-zA-Z]*/\."`; do
  echo ${file}
  cp ${file} ~/
  echo -e "All files done! Enjoy!"
done
