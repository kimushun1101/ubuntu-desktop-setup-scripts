#!/bin/sh
read -p "Did you import Mozc Property? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

cd `dirname $0`

sudo apt update

# assist for GUI installers
xdg-open https://www.google.com/chrome/
xdg-open https://code.visualstudio.com/docs/?dv=linux64_deb
xdg-open https://slack.com/intl/ja-jp/downloads/linux

sudo apt install -y vim xsel
mkdir ~/.vimbackup

# install Docker
sudo apt install -y curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm -f get-docker.sh 

# install terminator
sudo apt install -y terminator
mkdir -p ~/.config/terminator
cp -f terminator_config ~/.config/terminator/config

# gsettings
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
sudo timedatectl set-local-rtc true

mv ~/setup-ubuntu20 ~/.setup
ln -s .setup/vimrc ~/.vimrc
ln -s .setup/gvimrc ~/.gvimrc
ln -s .setup/bash_aliases ~/.bash_aliases
ln -s .setup/xkb ~/.xkb

echo "xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY" >> ~/.bashrc
echo "clear" >> ~/.bashrc
source ~/.bashrc
