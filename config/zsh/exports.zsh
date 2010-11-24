#!/bin/sh

## Variables et al
export BROWSER=firefox
export EDITOR=vim
export FM=pcmanfm
export PDFVIEWER=zathura
export IMGVIEWER=mirage
if [[ -d /usr/share/perl5/site_perl/auto/share/dist/Cope ]]; then
	export PATH=/usr/share/perl5/site_perl/auto/share/dist/Cope:$PATH
fi
export PATH=$HOME/bin:$PATH
#export LD_LIBRARY_PATH=$HOME/compiladores/root/usr/include/rts:$LD_LIBRARY_PATH

#rxvt
export RXVT_SOCKET=$HOME/.config/rxvt-unicode-ricardoArch

# speed up firefox
export MOZ_DISABLE_PANGO=1

#Less
export LESSCHARSET="utf-8"

# Colorized less, woohoo
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Colorized input files, yeah
export LESSOPEN='| /usr/bin/lesspipe.sh %s'
export LESSCLOSE='/usr/bin/lesspipe.sh %s %s'
export LESS='--RAW-CONTROL-CHARS --tabs=8 -r'

#Less has no memory
export LESSHISTFILE='/dev/null'

#history
export HISTFILE=$HOME/.histfile
export HISTIGNORE=ignoredups:ls:ll:la:l:rm:cd:dl:mkdir
export HISTSIZE=5000
export SAVEHIST=5000

#XDG vars
export XDG_DATA_HOME=/home/ricardo/.local/share 
export XDG_CONFIG_HOME=/home/ricardo/.config 
export XDG_CACHE_HOME=/home/ricardo/.cache 

#XAUTHORITY
export XAUTHORITY=$HOME/.config/.Xauthority

#cvs
#export CVSROOT=':ext:ist162578@comp.rnl.ist.utl.pt:/cvs'
#export CVS_RSH='ssh'

#Flex Yacc debug
#export YYDEBUG=1

#colors in the file by same name
