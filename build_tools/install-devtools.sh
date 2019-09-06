#!/bin/bash

echo
echo "Installing Dev Tools..."
echo

sudo apt-get purge vim vim-tiny
sudo apt-get install -y byobu vim-nox
sudo apt-get install -y htop build-essential dkms
sudo apt-get install -y python-pip python-virtualenv python-dev npm

echo
echo "Installing Dev Tools...  Done"
echo
echo "Upgrading setuptools..."
echo 

pip install -U pip setuptools

echo
echo "Upgrading setuptools...  Done"
echo
echo "Configuraing npm..."
echo

ln -s /usr/bin/nodejs /usr/bin/node
npm config set strict-ssl false
npm install -g npm@3.89
hash -r npm

echo
echo "Configuraing npm...  Done"
echo 
echo "Installing Vundle... "
echo 

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo 
echo "Installing Vundle...  Done"
echo
echo "Sync setup file"
echo

CUR_DIR=$(pwd)
cd $CUR_DIR
rsync -rvh --stats --progress --exclude "*.sh" --exclude "*.md" --exclude ".git/" --include ".*" . ~/

echo
echo "Sync setup file...  Done"
echo
echo "Installing vim plugin..."
echo

vim -c 'PluginInstall' -c 'qa!'

echo
echo "Installing vim plugin...  Done"
echo
echo "Configuring bashrc..."
echo

sed -i -r 's/#?force_color_prompt=.*$/force_color_prompt=yes/' ~/.bashrc
echo 'stty -ixon' >> ~/.bashrc

echo
echo "Configuring bashrc...  Done"
echo
echo "Completing other configuration..."
echo

sudo chown -R $USER /usr/local/lib
sudo chown -R $USER /usr/local/

pip install --user autopep8
npm install -g js-beautify@1.6.12
cd /tmp
wget http://downloads.sourceforge.net/project/astyle/astyle/astyle%203.1/astyle_3.1_linux.tar.gz
tar -zxf astyle_3.1_linux.tar.gz
cd /tmp/astyle/build/gcc
make
sudo make install
cd ~
sudo update-alternatives --set editor /usr/bin/vim.nox

echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
sudo chmod 0400 /etc/sudoers.d/$USER

echo
echo "     DONE"
echo

