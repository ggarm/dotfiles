#/bin/sh
LOWCOL='#cc896d'
CV="amixer -c0 get PCM | awk '/^  Front Left/ { print \$5 }' | tr -d '[]'" ;

echo -n "^ca(1,amixer -q set Master toggle)^ca(4,amixer -q sset PCM 10+ unmute)^ca(5,amixer -q sset PCM 10- unmute)";
MUTE=`amixer -c0 get Master | awk '/\[off\]/ {print $6}'`;
if [[ $MUTE == "[off]" ]]; then 
	echo -n "^fg($LOWCOL)Muted^ca()^ca()^ca()";
else
	VOL=$(eval "$CV");
	echo -n "$VOL^ca()^ca()^ca()";
fi
