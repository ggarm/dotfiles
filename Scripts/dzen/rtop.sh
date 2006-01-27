#!/bin/zsh
# vim:ft=zsh ts=4
#==============================================================================
#   DZEN BAR CONFIGURATION
#   Filename: rtop.sh
#   Requirements: bc, gdbar
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
BARBG=$MCOLOR                 # bg color gdbar
BARFG='#990000'                 # fg color gdbar
BARH=8                          # Height of gdbar
BARW=50                         # Width of gdbar

SLEEP=1

ICONPATH='/home/ricardo/Scripts/dzen/'      # Path to dzen icons
BCOLOR='#990000'                # Icon color

INTERFACE=eth0

RXB=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
TXB=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`
RXBN=`cat /sys/class/net/$INTERFACE/statistics/rx_bytes`
TXBN=`cat /sys/class/net/$INTERFACE/statistics/tx_bytes`

SDEVICE='PCM'

MYDATE_FORMAT='%H:%M:%S ' #- %a, %d.%m.%y'

#   MY FUNCTIONS
#------------------------------------------------------------------------------
mydate() {
    date  +${MYDATE_FORMAT}
}

netcalc() {

	INTERFACE=$1;
	echo "netcalc: $INTERFACE"

	RXBN=`cat /sys/class/net/$INTERFACE/statistics/rx_bytes`
	TXBN=`cat /sys/class/net/$INTERFACE/statistics/tx_bytes`

	RXR=$(printf "%4d\n" $(expr $(expr $RXBN - $RXB) / 1024))
	TXR=$(printf "%4d\n" $(expr $(expr $TXBN - $TXB) / 1024))

	print -n "^fg(${BARBG})$INTERFACE: ^fg(${BCOLOR})${RXR} ^fg(${BARBG})kB/s^fg(${BCOLOR})^p(3)^i(${ICONPATH}/xbm8x8/net_down_02.xbm)^fg(${BCOLOR})${TXR}\
		^fg(${BARBG})kB/s ^fg(${BCOLOR})^i(${ICONPATH}/xbm8x8/net_up_02.xbm)^fg()"

	RXB=$RXBN; TXB=$TXBN

}

netmon() {

	ESSID=`iwgetid -r`;
	if [[ -n $ESSID ]]; then
		INTERFACE='wlan0'
		netcalc $INTERFACE
	#else
		#INTERFACE='eth0'
		#netcalc $INTERFACE
	fi
}

volicon() {
	ismuted=`amixer -c0 get Master | awk '/\[off\]/ { print $6}'`

	if [[ $ismuted == "[off]" ]]
	then
		print "^fg(${MCOLOR})^i(${ICONPATH}/xbm8x8/spkr_02.xbm)"
	else
		print "^i(${ICONPATH}/xbm8x8/spkr_01.xbm)"
	fi
}

fvolume() {
	percentage=`amixer sget $SDEVICE | awk '/Front\ Left:/ {print $5}' | tr -d '[]%'`

	print -n "$(echo $percentage | gdbar -fg $BARFG -bg $BARBG -h $BARH -w $BARW -s o -nonl)" # Volume
}


#   OUTPUT FORMAT
#------------------------------------------------------------------------------
while true; do

	ESSID=`iwgetid -r`;
	if [[ -n $ESSID ]]; then
		INTERFACE='wlan0'
	else
		INTERFACE='eth0'
	fi
	RXBN=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
	TXBN=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

	RXR=$(printf "%4d\n" $(expr $(expr $RXBN - $RXB) / 1024))
	TXR=$(printf "%4d\n" $(expr $(expr $TXBN - $TXB) / 1024))

		#print " $(netmon)\
	print " ^fg(${MCOLOR})${INTERFACE}: ^fg($BCOLOR)${RXR} ^fg(${MCOLOR})kB/s ^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/net_down_02.xbm) ^fg($BCOLOR)${TXR} ^fg(${MCOLOR})kB/s ^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/net_up_02.xbm)\
		^ca(1, "amixer -q set Master toggle")^ca(4,amixer -q sset PCM 10+ unmute)^ca(5,amixer -q sset PCM 10- unmute)^fg($BCOLOR)$(volicon)  ^fg()$(fvolume)^ca()^ca()^ca()\
		^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/clock.xbm)   ^fg(#C4C4C4)$(mydate)"
	#   \^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/arch.xbm)"

	RXB=$RXBN; TXB=$TXBN

	sleep $SLEEP
done | $DIR/dzen2 -h 16 -x 900 -w 444 -ta r -fn '-*-montecarlo-*-r-*-*-10-*-*-*-*-*-*-*' -e ''
