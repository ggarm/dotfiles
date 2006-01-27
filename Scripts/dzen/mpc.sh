#/bin/sh
ICONPATH='/home/ricardo/Scripts/dzen/xbm'
DARKGRAY='#555555'
# MPC settings {{{
MPC_CAPTION="^i(${ICONPATH}8x8/phones.xbm)"
MPC_PLAY_CAPTION="^i(${ICONPATH}8x8/play.xbm)"
MPC_PAUSE_CAPTION="^i(${ICONPATH}8x8/pause.xbm)"
MPC_STOP_CAPTION="^i(${ICONPATH}8x8/stop.xbm)"
#MPC_SONG="/usr/bin/mpc current | tr '\n' ' ' "
MPC_SONG="/usr/bin/mpc current | cut -b-60"
#MPC_SONG="/usr/bin/mpc current | cut -b-60 | tr '\n' ' ' "
#MPC_FG='#B0AA83'
#MPC_FG='#F11E4A'
MPC_FG='#cc896d'
#MPC_FG='#F1104A'
# }}}

MPC=$(/usr/bin/mpc);
MPC_STATUS=$(echo "$MPC" | awk '/#/ {print $1}' );
#MPC_LENGTH=$(echo "$MPC"| awk '/#/ {print $4}');
#RAND=$(echo "$MPC"| awk '/random:/ {print $5}');
case $(echo $MPC_STATUS) in
	\[playing\])
echo -n "^ca(1,sonata -t)^ca(2,mpc -q toggle)^ca(4,mpc -q next)^ca(5,mpc -q prev)^fg($DARKGRAY)";
		#MPC_TIME_LEFT=`/usr/bin/mpc status | awk -F: '/#/ {print $3 - $2}'`;
		echo -n "$MPC_PLAY_CAPTION ";
		echo -n "^fg($MPC_FG)";
		MPC_SONGNAME=$(eval $MPC_SONG);
		echo -n "$MPC_SONGNAME";
echo -n "^ca()^ca()^ca()^ca()^fg()";
		;;
	\[paused\])
echo -n "^ca(1,sonata -t)^ca(2,mpc -q toggle)^ca(4,mpc -q next)^ca(5,mpc -q prev)^fg($DARKGRAY)";
		echo -n "$MPC_PAUSE_CAPTION ";
		echo -n "^fg($DARKGRAY)";
		MPC_SONGNAME=$(eval $MPC_SONG);
		echo -n "$MPC_SONGNAME";
echo -n "^ca()^ca()^ca()^ca()^fg()";
		;;
	*)
		#echo -n "$MPC_CAPTION^p(3X)";
		#echo -n "$MPC_STOP_CAPTION^p(3x)";
		;;
esac
