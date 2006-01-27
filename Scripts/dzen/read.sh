#/bin/sh
FILE='/home/ricardo/Scripts/wifi'
ESSID=`iwgetid -r`;

read essid <$FILE

if [[ -n $ESSID ]]; then
	if [[ $ESSID != $essid ]]; then
		echo -n "${ESSID} "
		echo "${ESSID}" > $FILE;
	fi
	echo -n `iwlist wlan0 scan | awk '/Quality/ { n = split (\$1, path, "=||/");\
		printf("%d%", path[2] * 100 / path[3])}'`
fi
