#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

(xmodmap .Xmodmap) &			#keymapping
(urxvtd -q -o -f) &				#URxvt daemon starts here
(nice -n-5 mpd 2>/dev/null) &	#MPD starts here
(mpdcron 2>/dev/null) &	#MPDCron starts here

WM=wmfs

case $WM in
	openbox)
		(nitrogen --restore) &
		(stalonetray 2>/dev/null) &		#systray in upper-right corner
		(statusbar.sh) &				#Dzen-statusbar (only for openbox, code-it... FIXME)
		exec dbus-launch --exit-with-session openbox-session
		;;
	xmonad)
		xsetroot -cursor_name left_ptr	#see above
		(nitrogen --restore) &
		(stalonetray 2>/dev/null) &		#systray in upper-right corner
		for i in {lbottom.sh,rbottom.sh,rtop.sh}; do
			(~/Scripts/dzen/$i) &
		done
		exec xmonad
		;;
	wmfs)
		for i in {lbottom.sh}; do
			(~/Scripts/dzen/$i) &
		done
		exec wmfs
		;;
	*)
		exec openbox-session
		;;
esac

(xmodmap .Xmodmap) &			#keymapping
#(setxkbmap pt) &				#pt-keys (Xorg ignores the conf file? FIXME)
#xload .Xdefaults				#Xmonad is retarded
xsetroot -cursor_name left_ptr	#see above

#unclutter &					#for hiding the mouse when idle
(urxvtd -q -o -f) &				#URxvt daemon starts here

#Disabled Apps #{{{
	#Non-Essential
		#(pcmanfm --desktop -d 2>/dev/null) &
		#(sleep 3; pytyle 2>/dev/null) &
		#(~/bin/mpd-notify.py 2>/dev/null) & 

	# Trays, icons
		#(idesk &>/dev/null) &
		#(tint2 &>/dev/null) &
		#(sleep 2; adeskbar 2>/dev/null) &

	#Stats in conky
		#(conky -c ~/.config/conky/stats 2>/dev/null) &
		#(conky -c ~/.config/conky/clock 2>/dev/null) &

	#Compositing
		#(xcompmgr -c -D 7 -f -F -n 2>/dev/null) &
		#(xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7 2>/dev/null) &
#}}}

(nitrogen --restore) &
#eval `cat ~/.fehbg` &			#Set the last wallpaper
#wallpaperd &					#Set a wallpaper per workspace

(stalonetray 2>/dev/null) &		#systray in upper-right corner

(nice -n-5 mpd 2>/dev/null) &	#MPD starts here

#(tmux) &						#tmux starts here (can't figure out the auto-start part... FIXME)

for i in {lbottom.sh,rbottom.sh,rtop.sh}; do
	(~/Scripts/dzen/$i) &
done

#xmonad
exec wmfs
