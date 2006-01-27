#!/bin/zsh
# vim:ft=zsh ts=4
#==============================================================================
#   DZEN BAR CONFIGURATION
#   Filename: rbottom.sh
#==============================================================================
#------------------------------------------------------------------------------
#   Last updated: September 1 - 2009
#   Changelog: Nothing much, just cleaning up the script.
#------------------------------------------------------------------------------


#   SETTINGS
#------------------------------------------------------------------------------
DIR='/usr/bin/'                 # Path to dzen
COLORFG='#616161'			# Reddish
COLORFG2="#909090"
COLORFG3="#c4df90"
COLORFG4="#cc896d"
COLORFG5="#c4df90"
COLORFG6="#ffffba"
COLORFG7="#b65def"				# Purple
MCOLOR=$COLORFG4                # main fg color
BARFG='#990000'                 # fg color gdbar
BARH=8                          # Height of gdbar
BARW=50                         # Width of gdbar

SLEEP=1

ICONPATH='/home/ricardo/Scripts/dzen/'      # Path to dzen icons
BCOLOR='#990000'                # Icon color

DZMAIL="urxvt -T mailbox -e mutt"
MAILFILE='/home/ricardo/Mail/GMAIL/Inbox';


# MY FUNCTIONS
#------------------------------------------------------------------------------
xmonadver() {
	echo -n " ^fg(${MCOLOR})$(xmonad --version) ^fg(#C4C4C4)- As above so below"
   #xmonad --version
}

pacman() {

	UP=`cat ~/Scripts/pacman_updates`;
	if [[ $UP -gt 0 ]]; then 
		echo -n "^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/pacman.xbm)^fg(#F7D981)   $UP ";
	else
		echo -n "^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/pacman.xbm)^fg(${MCOLOR})   $UP ";
	fi
	
}

smail() { 
	NEW_MAIL=`awk 'BEGIN { i=0 } /Message-I[[:alpha:]]:/ { i+=1 } END {print i}' $MAILFILE`;
	if [[ $NEW_MAIL -gt 0 ]]; then
		echo -n "^fg(#F7D981)$NEW_MAIL";
	else
		echo -n "^fg(${MCOLOR})$NEW_MAIL";
	fi
}


# OUTPUT FORMAT
#------------------------------------------------------------------------------
while true; do

	print "$(xmonadver)\
		$(pacman) \
		^fg($BCOLOR)^ca(1, ${DZMAIL})^i(${ICONPATH}/xbm8x8/mail.xbm)   $(smail) ^ca()"

    sleep $SLEEP
done | $DIR/dzen2 -h 20 -x 900 -y 1034 -ta r -fn '-*-montecarlo-*-r-*-*-10-*-*-*-*-*-*-*' -e ''
