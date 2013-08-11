#!/bin/bash
 
for file in `find . | grep "\./[a-zA-Z]*/\."`; do
  echo ${file}
  cp ${file} ~/
done

echo -e "All files done! Enjoy!"
