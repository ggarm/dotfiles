#!/bin/sh
## Aliases

if [[ $SHELL == *zsh ]]; then
	# Suffix aliases
	alias -s gz=tar -xzvf
	alias -s bz2=tar -xjvf
	alias -s nfo=pnfo
	alias -s {rar,zip,ZIP,7z}=7z X
	alias -s {sxw,doc,ppt,xls}=soffice
	alias -s {html,org,php,com,net}=$BROWSER
	alias -s {java,txt,c,cpp,h,PKGBUILD}=$EDITOR
	alias -s {asx,avi,wmv,mkv,mp4,mp3,wav}=mplayerd
	alias -s pdf=$PDFVIEWER
	alias -s {png,jpg,gif}=$IMGVIEWER
	alias -s exe=wine
	alias -s PKGBUILD=$EDITOR
	alias -s TODO=$EDITOR
	# Global aliases
	alias -g L='| less'
	alias -g T='| tail'
	alias -g G='| grep'
	alias -g E='| egrep'
	# Named Dirs
	# http://zshwiki.org/home/examples/aliasdirs
	hash -d zsh="$HOME/.config/zsh"
	hash -d abs="/var/abs"
	hash -d Ricardo="/mnt/Ricardo/"
	hash -d Prog="/mnt/Prog/"
fi

# mplayer --now-playing
alias mplayer='mplayer -msgcolor -msgmodule'
#alias mplayer='mplayer -identify $@> $HOME/.mplayer/mplayerd.log'

#Downloads & Torrent dir
alias dl='~/Downloads'
alias dlc='~/Downloads/Completed/'

#sudo
alias !='sudo'

#tmux - 256 color hack
#alias tmux='tmux -2 attach || tmux new'

#vim gvim - open in tabs
alias vim='vim -p' 
alias gvim='gvim -p'
alias vi='vim'
alias svi='sudo vim'

#ping
alias ping='ping -c 1 www.google.com'

#df
alias df='df -h'

#du
alias du='du -h -s -c'
alias dum='du * | egrep "[0-9]M|[0-9]G" '

#feh - preload, quiet, filenames visible, borderless
alias feh='feh -pqdx -Z --scale-down ' #-g 800x400'

#make
alias mk='make'
alias amke='make' 	#typos

#clisp
alias clisp='clisp -q'

#cd
alias back='cd $OLDPWD'
alias cd..='cd ..'
alias ..='cd ..'

#top10
alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

#ls
if [[ -f `which ls++` && $TERM != linux ]]; then
	alias ls='ls++';
elif [[ -f ~/bin/pilsner && $TERM != linux ]]; then
	alias ls='~/bin/pilsner';
else
	alias ls='ls --group-directories-first -hF --color=always'
fi
alias la='ls -A'
alias ll='ls -l --show-control-chars'
alias lla='ll -A'
alias lh='ls -lh'
alias lr='ls -R'
alias lx='ll -BX'	#sort by extension
alias lz='ll -rS'	#sort by size
alias lt='ll -rt'	#sort by date
alias lsq='ls -AlQ --color=always --time-style=full-iso'
if [[ -f `which ls++` && $TERM != linux ]]; then
	alias l='ls++';
fi

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

# Coding
alias gcc='gcc -Wall -Wextra -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings -Wmissing-declarations -Wredundant-decls -Wnested-externs -Winline -Wno-long-long -Winit-self -Wmissing-prototypes -Wstrict-prototypes -Wconversion -pedantic'
alias valgrind='valgrind --tool=memcheck --leak-check=full --show-reachable=yes'
alias gdb='gdb -ex run -ex backtrace --args'

#cpu
alias cpuu='ps -eo pcpu,pid,user,args | sort -n -r | head '

#typos
alias ç='l'
alias çç='ll'
alias xs='cd'
