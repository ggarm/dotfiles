#!/bin/sh

cd ~;
git clone git://github.com/ggarm/dotfiles.git;
REPO="$HOME/dotfiles"
DEST="$HOME"

ln -s $REPO/bashrc.bash $DEST/.bashrc
ln -s $REPO/zshrc.zsh $DEST/.zshrc
ln -s $REPO/inputrc $DEST/.inputrc
ln -s $REPO/vimrc $DEST/.vimrc

ln -s $REPO/bin $DEST/bin
ln -s $REPO/Scripts $DEST/Scripts
ln -s $REPO/config/vim $DEST/.vim

ln -s $REPO/Scripts/utils/pilsner $DEST/bin/pilsner

#for vim
mkdir $REPO/config/vim/backup

#RM
cd ~/Scripts;
rm bat.sh README;
rm -r dzen Hacks issues pacman rxvt;

cd ~/bin;
rm bigpkg.py dmenu* down-complete.sh firefox*;
rm fsize mpd-notify.py song-change.py shutdown*;

cd ~/dotfiles/config;
rm -r conky mplayer openbox pytyle vifm tint2 zathura;
rm -r vimperator;

#for i in {bashrc}
