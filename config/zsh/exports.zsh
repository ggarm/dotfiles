#!/bin/sh

## Variables et al
export BROWSER=chromium
export EDITOR=vim
export FM=nautilus
export PDFVIEWER=evince
export IMGVIEWER=mirage
if [[ -d /usr/lib/cw ]]; then
	export PATH=/usr/lib/cw:$PATH
fi
# [[ -d `cope_path` ]] && export PATH=`cope_path`:$PATH;
export PATH=$HOME/bin:$PATH
export PATH="/usr/lib/ccache/bin/:$PATH"

export CCACHE_DIR=/tmp/ccache             # Tell ccache to use this path to store its cache

#export LD_LIBRARY_PATH=$HOME/compiladores/root/usr/include/rts:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/devel/stderred/lib64/stderred.so

#rxvt
export RXVT_SOCKET=$HOME/.config/rxvt-unicode-ricardoArch

# speed up firefox
export MOZ_DISABLE_PANGO=1

# speed up opera
export OPERAPLUGINWRAPPER_PRIORITY=0
export OPERA_KEEP_BLOCKED_PLUGIN=1

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
# export XAUTHORITY=$HOME/.config/.Xauthority

#xfce global menu
# GTK_MODULES=globalmenu-gnome

#cvs
#export CVSROOT=':ext:ist162578@comp.rnl.ist.utl.pt:/cvs'
#export CVS_RSH='ssh'

#Flex Yacc debug
#export YYDEBUG=1

#colors in the file by same name
