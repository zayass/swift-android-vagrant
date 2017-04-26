#!/bin/bash


echo >> .bashrc
echo >> .bashrc
cat /vagrant/configs/functions.sh >> .bashrc
cat /vagrant/configs/functions.sh | grep '()' | grep -o '\w*' | xargs -L 1 echo export -f >> .bashrc


git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp /vagrant/configs/vimrc .vimrc
vim -T dumb +PluginInstall +qall
