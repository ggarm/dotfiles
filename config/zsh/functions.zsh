#!/bin/sh
## Functions

# Decompress any archive 
ex () {
 if [ -f "$1" ] ; then
   case "$1" in
	*.tar.bz2)	tar xvjf $1	;;
	*.tar.gz)	tar xvzf $1	;;
	*.tar.xz)	tar xvJf $1	;;
	*.bz2)		bunzip2 $1	;;
	*.rar)		7z X $1	;;
	*.gz)		gunzip $1	;;
	*.tar)		tar xvf $1	;;
	*.tbz2)		tar xvjf $1	;;
	*.tgz)		tar xvzf $1	;;
	*.zip)		7z X $1	;;
	*.Z)		uncompress $1	;;
	*.7z)		7z X $1		;;
	*.xz)		unxz $1		;;
	*.exe)		cabextract $1	;;
	*)	echo "\`$1': unrecognized file compression"	;;
    esac
  else
    echo "\`$1\' is not a valid file"
  fi
}

# Compress to an archive
roll() {
	local FILE
	FILE=$1
	case $FILE in
		*.tar.bz2)  shift && tar cjf $FILE $* ;;
		*.tbz2)     shift && tar cjf $FILE $* ;;
		*.tar.gz)   shift && tar czf $FILE $* ;;
		*.tgz)      shift && tar czf $FILE $* ;;
		*.zip)      shift && zip $FILE $*     ;;
		*.rar)      shift && rar $FILE $*     ;;
		*)			echo "Don't know that filetype: $1" ;;
	esac
}

# auto-ls on cd
cd () {
 builtin cd $@ && ls;
#  grep -s -i . README*;
 if [[ -n `find . -maxdepth 1 -name 'README*'` ]]; then
	 find . -maxdepth 1 -name 'README*' -exec v {} \; | more;
	 true;
 fi
 true;
}

if [[ -f ~/Scripts/utils/alias ]]; then
	salias () { ~/Scripts/utils/alias; }
fi

# Change permissions
function +x(){ chmod +x $1; }
function +w(){ chmod +w $1; }

# Timec
function timec {while sleep 1 ; do printf '\r%s ' "$(date +'%T %Y-%m-%d')" ; done}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }

# Create a new directory and enter it
mkcd () { mkdir $1 && cd $1; }

# Move file to a directory and enter it
mvcd () { mv $1 $2 && cd $2; }

# native function for showing 256 colors, properly formatted:
function 256co {
# if [[ ${TERM} != linux ]]; then
	for line in {0..15}; do for col in {0..15}; do
		local code=$(( $col * 16 + ${line} ))
		printf $'\e[38;05;%dm %03d' ${code} ${code}
	done
	print ; done
# fi
}

# Define stuff
google () {
 #url=$(echo http://google.com/search?q=$(echo "$@" | sed s/\ /+/g))
 url="http://google.com/search?q=$(echo "$@" | sed s/\ /+/g)"
 if [[ "$DISPLAY" = "" ]]; then
 	w3m $url
 else
	firefox "$url"
 fi
}

# Find and execute a command in history
hist () {
 #history | sed s/.*\ \ // | grep $@
 history | grep --color=auto $1

 echo "Execute  command #?"
 read number
 
 `history | grep $number | tr -s ' ' | cut -d ' ' -f 3-`
}

# pacman - no more manual sudo
pacman () {
	case $1 in
		(-Ss | -Si | -Q* | -T | -G | --stats)
			/usr/bin/pacman "$@" ;;
		(-S* | -R* | -U)
			/usr/bin/sudo /usr/bin/pacman "$@" ;;
		(*)
			/usr/bin/pacman "$@" ;;
	esac
	rehash
#   $HOME/Scripts/cron/pacman_updates.cron
	#/usr/bin/pacman -Qu | wc -l > ~/Scripts/pacman_updates;
}

# git functions
ga () { git add $*; }
gl () { git log $*; }
gs () { git status -s $*; }
gp () { git push $*; }
gpl () { git pull $*; }
gc () { 
	if [ -z "$1" ]; then
		git commit;
	else
		git commit -m "$*";
	fi
}
gco () {
	if [ -z "$1" ]; then
		git checkout master;
	else
		git checkout $1;
	fi
}
