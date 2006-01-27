#!/bin/zsh
# vim:ft=zsh ts=4
#==============================================================================
#   DZEN BAR CONFIGURATION
#   Filename: lbottom.sh
#   Requirements: gdbar
#==============================================================================
#------------------------------------------------------------------------------
#   Last updated: September 1 - 2009
#   Changelog: Nothing much, just cleaning up the script.
#------------------------------------------------------------------------------


#   SETTINGS
#------------------------------------------------------------------------------
DIR='/usr/bin/'                 # Path to dzen
BARBG='#616161'                 # bg color gdbar
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

ICONPATH='/home/ricardo/Scripts/dzen'      # Path to dzen icons
BCOLOR='#990000'                # Icon color

MAXPOS="100"

MPDRW="/usr/bin/mpc -q seek -10"
MPDFW="/usr/bin/mpc -q seek +10"
MPDN="/usr/bin/mpc -q next"
MPDP="/usr/bin/mpc -q prev"
MPDPLAY="/usr/bin/mpc -q toggle"
MPDSTOP="/usr/bin/mpc -q stop"

#   MY FUNCTIONS
#------------------------------------------------------------------------------
version() {
	uname -r
}

mpd() {
  POS=`/usr/bin/mpc | sed -ne 's/^.*(\([0-9]*\)%).*$/\1/p'`
  POSM="$POS $MAXPOS"
  echo "$POSM" | gdbar -h $BARH -w $BARW -fg $BARFG -bg $BARBG -s o -nonl
}

mpdtitle() {
	echo -n "^ca(1,sonata -t)^fg(${MCOLOR})Now Playing: ^fg(#C4C4C4)`/usr/bin/mpc current  `^ca()"
}

mpdplay() {
    # I guess there are more elegant ways of doing this, but it works.
	MPC_STATUS=$( /usr/bin/mpc | awk '/#/ {print $1}' );
	case $(echo $MPC_STATUS) in
		\[playing\])
			print "^i(${ICONPATH}/xbm8x8/play.xbm)"
			;;
		\[paused\])
			print "^i(${ICONPATH}/xbm8x8/pause.xbm)"
			;;
		*)
			print "^i(${ICONPATH}/xbm8x8/stop.xbm)"
			;;
	esac
}


# OUTPUT FORMAT
#------------------------------------------------------------------------------
while true; do

    print -n "  ^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/shroom.xbm)  ^fg(${MCOLOR})$(version)\
		^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/note.xbm) ^fg(${MCOLOR}) MPD: ^fg(${MCOLOR})^ca(1, ${MPDP})^i(${ICONPATH}/xbm8x8/prev.xbm)^ca() ^fg($BCOLOR)^ca(1, ${MPDPLAY})$(mpdplay)^ca() ^fg(${MCOLOR})^ca(1, ${MPDRW})^i(${ICONPATH}/xbm8x8/rwd.xbm)^ca() ^ca(1, ${MPDFW})^i(${ICONPATH}/xbm8x8/fwd.xbm)^ca() ^ca(1, ${MPDN})^i(${ICONPATH}/xbm8x8/next.xbm)^ca()  $(mpd)  $(mpdtitle) \n"

    sleep $SLEEP
#done | $DIR/dzen2 -h 20 -w 900 -y 1034 -ta l -fn '-*-liberation mono-*-r-*-*-10-*-*-*-*-*-*-*' -e ''
done | $DIR/dzen2 -h 20 -w 900 -y 1034 -ta l -fn '-*-montecarlo-*-r-*-*-10-*-*-*-*-*-*-*' -e ''
