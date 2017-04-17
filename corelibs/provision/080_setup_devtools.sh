#!/bin/bash


echo >> .bashrc
echo >> .bashrc
cat /vagrant/functions.sh >> .bashrc
cat /vagrant/functions.sh | grep '()' | grep -o '\w*' | xargs -L 1 echo export -f >> .bashrc


git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp /vagrant/vimrc .vimrc
vim +PluginInstall +qall
