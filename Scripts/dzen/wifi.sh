#/bin/sh
FILE='/home/ricardo/Scripts/wifi'
LINK='/sys/class/net/wlan0/wireless/link'
ESSID=`iwgetid -r`;

read essid <$FILE

if [[ -n $ESSID ]]; then
	if [[ $ESSID != $essid ]]; then
		echo -n "${ESSID} "
		echo "${ESSID}" > $FILE;
	fi
	read link <$LINK; echo -n "$link%"
	#echo -n `iwlist wlan0 scan last | awk '/Quality/ { n = split (\$1, path, "=||/");\
		#printf("%d%", path[2] * 100 / path[3])}'`
fi
