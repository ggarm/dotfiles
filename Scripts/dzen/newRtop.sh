#!/bin/zsh
# vim:ft=zsh ts=4
FILE='/home/ricardo/Scripts/wifi'
LINK='/sys/class/net/wlan0/wireless/link'
ESSID=`iwgetid -r`;
BARBG='#616161'                 # bg color gdbar
BARFG='#990000'                 # fg color gdbar
BARH=8                          # Height of gdbar
BARW=50                         # Width of gdbar
ICONPATH='/home/ricardo/Scripts/dzen/'      # Path to dzen icons
BCOLOR='#990000'                # Icon color
INTERFACE=wlan0

RXB=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
TXB=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

SDEVICE='PCM'

MYDATE_FORMAT='%H:%M:%S - %a, %d.%m.%y'

mydate() {
    date  +${MYDATE_FORMAT}
}

netmon() {

read essid <$FILE

if [[ -n $ESSID ]]; then
	if [[ $ESSID != $essid ]]; then
		echo -n "${ESSID} "
		echo "${ESSID}" > $FILE;
	fi
	read link <$LINK; echo -n "${INTERFACE}: $link%"
	#echo -n `iwlist wlan0 scan last | awk '/Quality/ { n = split (\$1, path, "=||/");\
		#printf("%d%", path[2] * 100 / path[3])}'`

   RXBN=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
   TXBN=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

   RXR=$(printf "%4d\n" $(expr $(expr $RXBN - $RXB) / 1024))
   TXR=$(printf "%4d\n" $(expr $(expr $TXBN - $TXB) / 1024))

   print -n "^fg(white)${RXR} kB/s^fg(#80AA83)^p(3)^i(${ICONPATH}/xbm8x8/net_down_02.xbm)^fg(white)${TXR} kB/s^fg(orange3)^i(${ICONPATH}/xbm8x8/net_up_02.xbm)^fg()"

   RXB=$RXBN
   TXB=$TXBN
fi

}

volicon() {
    ismuted=`amixer -c0 get Master | awk '/\[off\]/ { print $6}'`

    if [[ $ismuted == "[off]" ]]; then
        print "^fg(#616161)^i(${ICONPATH}/xbm8x8/spkr_02.xbm)"
	else
        print "^i(${ICONPATH}/xbm8x8/spkr_01.xbm)"
    fi
}

fvolume() {
    percentage=`amixer sget $SDEVICE | awk '/Front\ Left:/ {print $5}' | tr -d '[]%'`

	print -n "$(echo $percentage | gdbar -fg $BARFG -bg $BARBG -h $BARH -w $BARW -s o -nonl)" # Volume
}

print -n "$(netmon)\
	^ca(1, "amixer -q set Master toggle")^ca(4,amixer -q sset PCM 10+ unmute)^ca(5,amixer -q sset PCM 10- unmute)^fg($BCOLOR)\
	$(volicon)  ^fg()$(fvolume)^ca()^ca()^ca() \
	^fg($BCOLOR)^i(${ICONPATH}/xbm8x8/clock.xbm)   ^fg(#C4C4C4)$(mydate)   \
	^fg($BCOLOR)^i($ICONPATH/xbm8x8/arch.xbm)"

