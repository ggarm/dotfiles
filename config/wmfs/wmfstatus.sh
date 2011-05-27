# ------------------------------------------------------
# file:     $HOME/.config/wmfs/wmfstatus.sh
# author:   Ricardo Costa 
# modified: 2011-03-27 05:41
# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=sh:
# ------------------------------------------------------

# -----
# Paths
# -----
ICONPATH="$HOME/Scripts/wmfs/icons"
STATEFILE='/proc/acpi/battery/BAT1/state' # battery's state file
# -------------
# Defining VARS
# -------------
        read UP < /tmp/pacman_updates;
        if [[ $UP -gt 0 ]]; then 
            PACMAN="
            \i[850;1;0;0;$ICONPATH/ghost2.png]\ 
            \s[865;12;#DCDCDC; $UP]\ "
#            \s[865;12;#DCDCDC; is sad...]\ "
        fi

        RCAP=`awk '/remaining/ {print $3 }' $STATEFILE`;
        if [[ -n $RCAP ]]; then
            # calculate remaining power
            RPERC=`expr $RCAP \* 100 / 4800`;
             
            if [ "$RPERC" -lt "15" ]; then
                if [ `cat /tmp/batteryfail` = "1" ]; then
                    color="#ff0000"
                    echo 0 > /tmp/batteryfail
                    POWER="
                    \i[977;4;0;0;$ICONPATH/bat_full_02.png]\ 
                    \s[985;12;$color; $RPERC%]\ "
                else
                    echo 1 > /tmp/batteryfail
                fi
            else
                color="#DCDCDC" #52E83E"
                POWER="
                \i[972;4;0;0;$ICONPATH/bat_full_02.png]\ 
                \s[980;12;$color; $RPERC%]\ "
#                \s[1000;12;#8F8F8F; |]\ "
            fi
#            if [ $RPERC -le 15 ]; then color="#EE0000";
#            elif [ $RPERC -le 50 ]; then color="#E1DF3A";
#            else color="#52E83E";
#            fi
        fi 

#        DATE=$(/bin/date "+%H:%M:%S")
        DATE=$(/bin/date "+%H:%M")
		SDA4=$(/bin/df -h /home | awk '/home/ {print $4}')
		SDA2=$(/bin/df -h / | awk '/\/$/ {print $4}')
		#TEMP=$(cat /proc/acpi/thermal_zone/TZ01/temperature | awk '{print $2}')
        VOL=$(amixer get PCM | awk '/Front\ Left:/ {print $5}' | tr -d '[]')
        #VOL=$(amixer get PCM | awk '/Front\ Left:/ {print $5}' | sed -e 's/\[//g' -e 's/]//g')
#        MEM=$(/usr/bin/free -t -m | awk '/Total:/ {print $3}')
#        MEM=$(awk '/MemFree:/ { printf("%.0f", $2 / 1024 )}' /proc/meminfo)
        MEM=$(/usr/bin/vmstat -S M -s | awk '/ active/ {print $1}')
        LOAD=$(awk '{print $1,$2,$3;}' /proc/loadavg)
        # CPU lines courtesy Procyon: https://bbs.archlinux.org/viewtopic.php?pid=661592
		#CPU0=$(eval $(awk '/^cpu0 /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); 
            #sleep 0.4; 
            #eval $(awk '/^cpu0 /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); 
            #intervaltotal=$((total-${prevtotal:-0})); 
            #echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")
		#CPU1=$(eval $(awk '/^cpu1 /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); 
            #sleep 0.4; 
            #eval $(awk '/^cpu1 /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); 
            #intervaltotal=$((total-${prevtotal:-0})); 
            #echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")

# ---------
# The print 
# ---------
#\i[896;3;0;0;$ICONPATH/temp.png]\ 
#\s[933;12;#8F8F8F;|]\ 
#\s[910;12;#DCDCDC;$TEMP C]\ 
#$(wmfs-status-gauge 954 2 35 3 '#df0031' 1 '#333333' $CPU0) \
#$(wmfs-status-gauge 954 8 35 3 '#df0031' 1 '#333333' $CPU1) \
wmfs -s "
        $POWER
        $PACMAN
		\i[1014;3;0;0;$ICONPATH/cpu.png]\ 
        \s[1117;12;#8F8F8F;|]\ 
		\i[1125;3;0;0;$ICONPATH/mem.png]\ 
		\s[1140;12;#DCDCDC;$MEM MB]\ 
        $LOAD
		\s[1182;12;#8F8F8F;|]\ 
		\i[1190;3;0;0;$ICONPATH/hd.png]\ 
		\s[1203;12;#DCDCDC;/: $SDA2]\ 
		\s[1253;12;#DCDCDC;/home: $SDA4]\ 
		\s[1318;12;#8F8F8F;|]\ 
		\i[1327;3;0;0;$ICONPATH/spkr_01.png]\ 
        $(wmfs-status-gauge 1339 4 35 5 '#2c8cd7' 1 '#333333' $VOL) \
		\s[1380;12;#8F8F8F;|]\ 
		\s[1400;12;#DCDCDC;$DATE]\ 
		\i[1387;3;0;0;$ICONPATH/clock.png]\ 
        "
