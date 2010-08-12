#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

(xmodmap .Xmodmap) &

(setxkbmap pt) &

#for disabling the touchpad when I am writing
#(syndaemon -i 2 -d) &

# Prettify apps
# fbsetbg -l &
#(idesk &>/dev/null) &
#(tint2 &>/dev/null) &
#(sleep 1; cairo-dock -o &>/dev/null) &
#(conky -c ~/.config/conky/stats 2>/dev/null) &
#(conky -c ~/.config/conky/clock 2>/dev/null) &

eval `cat ~/.fehbg` &

#(pcmanfm --desktop -d 2>/dev/null) &
(adeskbar 2>/dev/null) &
#(trayer --edge bottom --align right --widthtype request --transparent true --alpha 255 --tint ffffff --SetDockType true --SetPartialStrut false --expand true) &
#(xcompmgr -c -D 7 -f -F -n 2>/dev/null) &
(xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7 2>/dev/null) &

#Using mpd for now...
(mpd 2>/dev/null) &

(urxvtd -q -o -f) &
(tmux -2 attach) &
#(urxvt -e tmux -2 attach) &

# TODO: check if there is internet before launch
nocope ping -c 1 www.google.com 2>/dev/null && (thunderbird 2>/dev/null) &
#(sleep 3; sonata --hidden 2>/dev/null) &

(statusbar.sh) &

#exec ck-launch-session openbox-session
#exec startfluxbox
exec dbus-launch --exit-with-session openbox-session
