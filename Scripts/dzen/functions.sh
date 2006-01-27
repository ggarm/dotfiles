#!/bin/sh
#functions for the statusbar

. $HOME/Scripts/dzen/settings.sh

#Workspace {{{
workspace () {
	WS=` wmctrl -d | awk '/\*/ {print $10}' `;
	WS_INFO=`wmctrl -l`;
	#WS=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'

	i=0;
	for ws in {main,web,code,misc}; do
		echo -n "^ca(1,wmctrl -s $i)";
		NUM_WIN=`echo $WS_INFO | awk "/ $i $HOST/"'{ i += 1 } END { print i }' `;
		#echo -n "$NUM_WIN";
		if [[ $WS == $ws ]]; then
			echo -n "^fg(gray)$ws";
			if [[ $NUM_WIN -gt 0 ]]; then
				echo -n "$WS_ACTIVE";
			else
				echo -n " ";
			fi
		else
			echo -n "^fg($DARKGRAY)$ws";
			if [[ $NUM_WIN -gt 0 ]]; then
				echo -n "^fg(gray)$WS_INACTIVE";
			else
				echo -n " ";
			fi
		fi
		echo -n "^ca()^fg()";
		i=`expr $i + 1` #shell script i++
	done
 }
# }}}

#MPD {{{
mpd () {
	MPC=$(/usr/bin/mpc);
	MPC_STATUS=$(echo "$MPC" | awk '/#/ {print $1}' );

	echo -n "^p(10X)";
	echo -n "^ca(1,sonata -t)^ca(2,mpc -q toggle)^ca(4,mpc -q next)^ca(5,mpc -q prev)^fg($DARKGRAY)";
	case $(echo $MPC_STATUS) in
		\[playing\])
			#MPC_TIME_LEFT=`/usr/bin/mpc status | awk -F: '/#/ {print $3 - $2}'`;
			MPC_LENGTH=$(echo "$MPC"| awk '/#/ {print $4}');
			#MPC_LENGTH=$(echo "$MPC"| awk -F'[()]' '/#/ {print $2}');
			echo -n "$MPC_CAPTION^p(3X)";
			echo -n "^ca(1,mpc -q random)";
			echo -n "[";
			STAT=$(echo "$MPC"| awk '/random:/ {print $5}');
			echo -n "$STAT";
			echo -n "]";
			echo -n "^ca()";
			echo -n $MPC_PLAY_CAPTION;
			echo -n "$MPC_LENGTH ";
			echo -n "^fg($MPC_FG)";
			MPC_SONGNAME=$(eval $MPC_SONG);
			echo -n "$MPC_SONGNAME";
		;;
		\[paused\])
			MPC_LENGTH=$(echo "$MPC"| awk '/#/ {print $3}');
			echo -n "$MPC_CAPTION^p(3X)";
			echo -n $MPC_PAUSE_CAPTION;
			echo -n "^fg($DARKGRAY)";
			echo -n "($MPC_LENGTH) ";
			MPC_SONGNAME=$(eval $MPC_SONG);
			echo -n "$MPC_SONGNAME";
		;;
		*)
			#echo -n "$MPC_CAPTION^p(3X)";
			#echo -n "$MPC_STOP_CAPTION^p(3x)";
		;;
	esac
	echo -n "^ca()^ca()^ca()^ca()^fg()";
}
#}}}

#LOAD {{{
load () {
 echo -n "^fg($DARKGRAY)";
 echo -n "$CPU_CAPTION^p(3X)";
 perl ~/Scripts/dzen/load.pl;
 #echo -n `uptime | awk '// {print $(NF-2), $(NF-1), $NF}' `;
 }
#}}}

#WIFI {{{
wifi () {
 echo -n "^p(_RIGHT)";
 echo -n "^p(-510)";
 echo -n "^fg($DARKGRAY)";
 ESSID=`iwgetid -r`;
 echo -n "$WIFI_CAPTION ";
 if [[ -n $ESSID ]]; then
	 echo -n "^fg($HIGHCOL)$ESSID";
	 #Net info {{{
	 echo -n "^p(_RIGHT)";
	 echo -n "^p(-400)";
	 # get new rx/tx counts
	 RXBN=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
	 TXBN=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

	 # calculate the rates
	 # format the values to 4 digit fields
	 RXDIFF="$(expr $RXBN - $RXB)"
	 TXDIFF="$(expr $TXBN - $TXB)"
	 RXR="$(echo $(expr $RXDIFF / 1024 / $SLEEP ))"
	 TXR="$(echo $(expr $TXDIFF / 1024 / $SLEEP ))"
	 RXR_UNIT="Kb/s"
	 TXR_UNIT="Kb/s"
	 #if [[ ${RXR} -gt 1024 ]]; then
		 #RXR="$(echo $(expr $RXR / 1024 ))"
		 #RXR_UNIT="Mb/s"
	 #else
		 #RXR_UNIT="Kb/s"
	 #fi
	 #if [[ ${TXR} -gt 1024 ]]; then
		 #TXR="$(echo $(expr $TXR / 1024 ))"
		 #TXR_UNIT="Mb/s"
	 #else
		 #TXR_UNIT="Kb/s"
	 #fi
	 #RXR="$(printf "%4d" $(echo $(expr $RXDIFF / 1024)) )"
	 #TXR="$(printf "%4d" $(echo $(expr $TXDIFF / 1024)) )"

	 echo -n "^fg($DARKGRAY)^i(${ICONPATH}8x8/net_down_01.xbm)";
	 if [[ ${RXR} -gt 0 ]]; then
		 echo -n "^p(2X)^fg(#80AA83)${RXR}";
	 else
		 echo -n "^p(2X)${RXR}";
	 fi
	 echo -n " ${RXR_UNIT}";

	 echo -n "^p(_RIGHT)^p(-330X)";
	 echo -n "^fg($DARKGRAY)^i(${ICONPATH}8x8/net_up_01.xbm)"
	 if [[ ${TXR} -gt 0 ]]; then
		 echo -n "^p(2X)^fg(orange3)${TXR}";
	 else
		 echo -n "^p(2X)${TXR}";
	 fi
	 echo -n " ${TXR_UNIT}";

	 # reset old rates
	 RXB=$RXBN; TXB=$TXBN
	 #}}}
 else
	 echo -n "^fg($LOWCOL)Disconnected";
 fi
}
#}}}

#MAIL {{{
mail () {
	echo -n "^p(_RIGHT)^p(-260)";
	echo -n "^fg($DARKGRAY)";
	echo -n "$MAIL_CAPTION^p(3X)";
	NEW_MAIL=`awk 'BEGIN { i=0 } /Message-I[[:alpha:]]:/ { i+=1 } END {print i}' $MAILFILE`;
	if [[ $NEW_MAIL -gt 0 ]]; then
		echo -n "^fg($LOWCOL)";
	fi
	echo -n "$NEW_MAIL";
}
#}}}

#PACMAN {{{
pacman () {
	echo -n "^p(_RIGHT)^p(-230X)";
	echo -n "^fg($DARKGRAY)";
	echo -n "$PACMAN_CAPTION^p(3X)";


	UP=`cat ~/Scripts/pacman_updates`;
	if [[ $UP -gt 0 ]]; then 
		echo -n "^fg(yellow3)";
	fi
	echo -n $UP;
}
#}}}

#BATTERY {{{
battery () {
	echo -n "^p(_RIGHT)^p(-210X)";
	echo -n "^fg($DARKGRAY)";
	RCAP=`awk '/remaining/ {print $3 }' $STATEFILE`;
	if [[ -n $RCAP ]]; then
		# calculate remaining power
		RPERC=`expr $RCAP \* 100 / $BAT_TOTAL`;
		 
		if [ $RPERC -le 15 ]; then BAT_GFG=$LOWCOL; BAT_CAPTION=$BAT_LOW;
		elif [ $RPERC -le 50 ]; then BAT_GFG=$MIDCOL; BAT_CAPTION=$BAT_MID;
		else BAT_GFG=$HIGHCOL; BAT_CAPTION=$BAT_FULL;
		fi
		echo -n "^p(3X) $BAT_CAPTION^p(3X)";
		#echo -n `echo -n "$RPERC" | gdbar -s o -h $BAT_GH -w $BAT_GW -fg $BAT_GFG -bg $BAT_GBG;`
		echo -n "^fg($BAT_GFG)$RPERC%^fg()";

		SLEEP=5; #let's save some power...
	else
		echo -n "^p(3X) $AC_CAPTION ^fg($DARKGRAY)On^fg()";
	fi 
}
#}}}

#VOLUME {{{
volume () {
	echo -n "^p(_RIGHT)^p(-160X)";
	echo -n "^fg($DARKGRAY)";
	echo -n "^ca(1,amixer -q set Master toggle)";
	MUTE=`amixer -c0 get Master | awk '/\[off\]/ {print $6}'`;
	if [[ $MUTE == "[off]" ]]; then 
		echo -n $VOL_CAPTION_MUTE;
		echo -n "^p(3X)";
		echo -n "^fg($LOWCOL)Muted^ca()";
	else
		VOL=$(eval "$CV");
		echo -n $VOL_CAPTION;
		echo -n "^p(3X)";
		if [[ $VOL != $OLD_VOL ]]; then
			echo -n "^fg(lightblue3)";
		fi
		echo -n "$VOL^ca()";
		OLD_VOL=$VOL;
	fi
	#echo -n $NUM | gdbar -nonl -ss 0 -s v -sw 8 -sh 1 -h $VOL_GH -w $VOL_GW -fg $VOL_GFG -bg $VOL_GBG;
}
#}}}

#TIME {{{
time() {
	echo -n "^p(_RIGHT)";
	echo -n "^p(-97X)";
	echo -n "^fg($DARKGRAY)";
	echo -n "$TIME_CAPTION "
	echo -n "^p(3X)";
	echo -n `date +"%d %b"`;
	echo -n " ^fg(gray)"
	echo `date +"%H:%M"`;
	#echo -n "^p(-55X)";
	#echo `date +"%H:%M" `;
}
#}}}
