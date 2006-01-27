#!/bin/sh

BG='#101010'     # dzen background
FG='#ffffff'     # dzen foreground
W=45         # width of the dzen bar
GW=40         #  width of the volume gauge
GH=7          # height of the gauge
GFG='#395573' # color of the gauge
GBG='#333'    # color of gauge background
VOL_GW=10         #  width of the volume gauge
VOL_GH=20          # height of the gauge
VOL_GFG='#395573' # color of the gauge
VOL_GBG='#333'    # color of gauge background
BAT_GW=50      # width of the gauge
BAT_GH=7       # height of the gauge
BAT_GFG='#80CC83'  # color of the gauge
BAT_GBG='#333'  # color of gauge background
X=0         # x position
Y=0         # y position
 
# Font to use
#FN='-xos4-terminus-*-*-*-*-10-*-*-*-*-*-*-*'
#FN='-*-terminal-*-*-*-*-10-*-*-*-*-*-*-*'
#FN='-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*'
FN="-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252"


SLEEP=1         # time interval in seconds
ICONPATH='/home/ricardo/Scripts/dzen/xbm'

# Settings {{{
# Workspace
	WS_ACTIVE="^i(${ICONPATH}/has_win.xbm)"
	WS_INACTIVE="^i(${ICONPATH}/has_win_nv.xbm)"
	NUM_WS="xprop -root _NET_NUMBER_OF_DESKTOPS|awk '{print $3}'"
	HOST=ricardoArch
# Tasks settings
	TASK_ACTIVE_ID=`xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}' | cut -b 3-`;
	#TASK_ACTIVE_NAME=`wmctrl -l | awk "/$TASK_ACTIVE_ID/"'{for (i=4; i<=NF; i++) print $i;}' | cut -b-70`;
	TASK_FG='#afff2f'
# Mail settings
	MAIL_CAPTION="^i(${ICONPATH}8x8/mail.xbm)"
	MAILFILE='/home/ricardo/Mail/GMAIL/Inbox';
# Battery settings {{{
STATEFILE='/proc/acpi/battery/BAT1/state' # battery's state file
INFOFILE='/proc/acpi/battery/BAT1/info'   # battery's info file
 
#LOWBAT=15        # percentage of battery life marked as low
LOWCOL='#ff4747' # color when battery is low
MIDCOL='khaki' # color when battery is low
HIGHCOL='#80CC83' # color when battery is low

#BAT_CAPTION="^i(${ICONPATH}/power-bat2.xbm)"
BAT_FULL="^i(${ICONPATH}8x8/bat_full_02.xbm)"
BAT_MID="^i(${ICONPATH}8x8/bat_low_02.xbm)"
BAT_LOW="^i(${ICONPATH}8x8/bat_empty_02.xbm)"
AC_CAPTION="^i(${ICONPATH}8x8/ac_01.xbm)"
 
BAT_TOTAL=4800;
#RCAP=`cat $STATEFILE|grep remaining|cut -d " " -f 8`;
#}}}
# Volume settings {{{
# Captions of the gauge
VOL_CAPTION="^i(${ICONPATH}8x8/spkr_01.xbm)"
VOL_CAPTION_MUTE="^i(${ICONPATH}8x8/spkr_02.xbm)"
	 
# command to increase the volume
CI="amixer -c0 sset PCM 2dB+ >/dev/null"
# command to decrease the volume
CD="amixer -c0 sset PCM 2dB- >/dev/null"
 
#CV="amixer -c0 get PCM | awk '/^  Front Left/ { print \$4 * 100 / $MAX}'"
CV="amixer -c0 get PCM | awk '/^  Front Left/ { print \$5 }' | tr -d '[]'" ;
#CV="aumix -q | line | cut -d \" \" -f 3"

# }}}
# MPC settings {{{
MPC_CAPTION="^i(${ICONPATH}8x8/phones.xbm)"
MPC_PLAY_CAPTION="^i(${ICONPATH}8x8/play.xbm)"
MPC_PAUSE_CAPTION="^i(${ICONPATH}8x8/pause.xbm)"
MPC_STOP_CAPTION="^i(${ICONPATH}8x8/stop.xbm)"
#MPC_SONG="/usr/bin/mpc current | tr '\n' ' ' "
MPC_SONG="/usr/bin/mpc current | cut -b-60 | tr '\n' ' ' "
#MPC_FG='#7744AA'
#MPC_FG='#B0AA83'
MPC_FG='#F11E4A'
#MPC_FG='#F1104A'
# }}}
# Load settings
CPU_CAPTION="^i(${ICONPATH}8x8/cpu.xbm)"
# Net settings
INTERFACE=wlan0
	# Here we remember the previous rx/tx counts
	RXB=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
	TXB=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`
# WIFI settings
WIFI_CAPTION="^i(${ICONPATH}8x8/wifi_01.xbm)"
# Pacman settings
PACMAN_CAPTION="^i(${ICONPATH}8x8/pacman.xbm)";
PACMAN_FILE='~/Scripts/pacman_updates';
# Colors
DARKGRAY='#555555'
# Time
TIME_CAPTION="^i(${ICONPATH}8x8/clock.xbm)";
# }}}
