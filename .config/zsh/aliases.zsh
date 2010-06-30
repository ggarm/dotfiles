#!/bin/sh
## Aliases
# Check for pacman-color
if [ -f /usr/bin/pacman-color ]
then alias pacman='pacman-color $@'
fi

# clyde - pacman wrapper

#sudo
alias !='sudo'

#tmux - 256 color hack
alias tmux='tmux -2 attach || tmux new'

#vim gvim - open in tabs
alias vim='vim -p' 
alias gvim='gvim -p'
alias vi='vim'
alias svi='sudo vim'
alias suvi='svi'

#ping
alias ping='ping -c 3 www.google.com'

#df
alias df='df -h'

#du
alias du='du -h -s -c'

#feh - preload, quiet, filenames visible, borderless
alias feh='feh -pqdx -Z --scale-down ' #-g 800x400'

#make
alias mk='make'
alias amke='make' 	#typos

#clisp
alias clisp='clisp -q'

#Downloads dir
alias dl='cd ~/Downloads/'
#Music dir
alias music='cd /media/Prog/TORRENT/Music/'

#cd
alias back='cd $OLDPWD'
alias cd..='cd ..'
alias ..='cd ..'

#ls
alias ls='ls --group-directories-first -hF --color=always'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'
alias lh='ls -lh'
alias lr='ls -R'
alias lx='ll -BX'	#sort by extension
alias lz='ll -rS'	#sort by size
alias lt='ll -rt'	#sort by date
alias l='ls -1' 	#because of typos

#power management
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'

#fortune-mod
alias fortune='fortune -acs'

#grep & co
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#xterm
alias xterm='xterm -bg black -fg green -cr orange -geometry 80x25'

#ssh
alias sigma='ssh sigma.ist.utl.pt -l ist162578'
alias comp='ssh comp.rnl.ist.utl.pt -l ist162578'

#typos
alias ç='l'
alias çç='ll'
