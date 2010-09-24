#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

(xmodmap .Xmodmap) &

(setxkbmap pt) &

#for hiding the mouse when idle
unclutter &

# Prettify apps
#(idesk &>/dev/null) &
#(tint2 &>/dev/null) &
#(conky -c ~/.config/conky/stats 2>/dev/null) &
#(conky -c ~/.config/conky/clock 2>/dev/null) &

eval `cat ~/.fehbg` &
(pytyle >/dev/null 2>/dev/null) &

#(pcmanfm --desktop -d 2>/dev/null) &
(tint2 -c ~/.config/tint2/tint2rc.icons) &
#(adeskbar 2>/dev/null) &
#(trayer --edge bottom --align right --widthtype request --transparent true --alpha 255 --tint ffffff --SetDockType true --SetPartialStrut false --expand true) &
#(xcompmgr -c -D 7 -f -F -n 2>/dev/null) &
#(xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7 2>/dev/null) &

#Using mpd for now...
(mpd 2>/dev/null) &
(amixer -q -c0 set PCM 25% ) &
(~/bin/mpd-notify.py 2>/dev/null) & 

(urxvtd -q -o -f) &
(tmux -2 attach) &

#( /bin/ping -c 1 www.google.com 2>/dev/null && (thunderbird 2>/dev/null) ) &

(sleep 1; statusbar.sh) &
#(sleep 2; netcfgfx 2>/dev/null) &

#If at home don't annoy me
if [[ `iwgetid | awk '{print $2}'` == ESSID:\"DLink-B686C5\" ]]; then
	(netcfgfx 2>/dev/null) &
fi

#exec startfluxbox
#exec ck-launch-session openbox-session
exec dbus-launch --exit-with-session openbox-session
#exec xmonad
