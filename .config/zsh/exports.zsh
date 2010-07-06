#!/bin/sh

## Variables et al
export BROWSER=firefox
export EDITOR=vim
export PDFVIEWER=zathura
export IMGVIEWER=mirage
export PATH=/usr/share/perl5/site_perl/5.10.1/auto/share/dist/Cope:$HOME/bin:$PATH
#export LD_LIBRARY_PATH=$HOME/compiladores/root/usr/include/rts:$LD_LIBRARY_PATH

#rxvt
export RXVT_SOCKET=$HOME/.config/rxvt-unicode-ricardoArch

# speed up firefox
export MOZ_DISABLE_PANGO=1

# Colorized less, woohoo
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Less has no memory
export LESSHISTFILE='/dev/null'

#history
export HISTFILE=$HOME/.histfile
export HISTIGNORE=ignoredups:ls:ll:la:l:rm:cd:dl:mkdir
export HISTSIZE=5000
export SAVEHIST=5000

#XDG vars
XDG_DATA_HOME=/home/ricardo/dotfiles/.local/share 
XDG_CONFIG_HOME=/home/ricardo/dotfiles/.config 
XDG_CACHE_HOME=/home/ricardo/dotfiles/.cache 

#cvs
#export CVSROOT=':ext:ist162578@comp.rnl.ist.utl.pt:/cvs'
#export CVS_RSH='ssh'

#Flex Yacc debug
#export YYDEBUG=1

#colors in the file by same name
