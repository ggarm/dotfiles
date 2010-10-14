#!/bin/sh
## Functions

# Decompress any archive TODO use only 7z
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
 grep -s -i . README;
 true;
}

if [[ -f ~/Scripts/utils/alias ]]; then
	salias () { ~/Scripts/utils/alias; }
fi


# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }

# Create a new directory and enter it
mkcd () { mkdir $1 && cd $1; }

# Move file to a directory and enter it
mvcd () { mv $1 $2 && cd $2; }

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

# clyde - no more manual sudo
clyde () {
	case $1 in
		(-Ss | -Si | -Q* | -T | -G | --stats)
			/usr/bin/clyde "$@" ;;
		(-S* | -R* | -U)
			/usr/bin/sudo /usr/bin/clyde "$@" ;;
		(*)
			/usr/bin/clyde "$@" ;;
	esac
	rehash
	/usr/bin/clyde -Qu | wc -l > ~/Scripts/pacman_updates;
}

# git functions
ga () { git add $*; }
gl () { git log $*; }
gs () { git status $*; }
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
