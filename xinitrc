#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#(setxkbmap pt) &				#pt-keys (Xorg ignores the conf file? FIXME)
#unclutter &					#for hiding the mouse when idle
(xmodmap .Xmodmap) &			#keymapping
(urxvtd -q -o -f) &				#URxvt daemon starts here
(nice -n-5 mpd 2>/dev/null) &	#MPD starts here
(mpdcron 2>/dev/null) &	#MPDCron starts here
#(tmux) &						#tmux starts here (can't figure out the auto-start part... FIXME)

WM=wmfs

case $WM in
	openbox)
		(nitrogen --restore) &
		(stalonetray 2>/dev/null) &		#systray in upper-right corner
		(statusbar.sh) &				#Dzen-statusbar (only for openbox, code-it... FIXME)
		exec dbus-launch --exit-with-session openbox-session
		;;
	xmonad)
		xsetroot -cursor_name left_ptr	#Xmonad is retarded
		(nitrogen --restore) &
		(stalonetray 2>/dev/null) &		#systray in upper-right corner
		for i in {lbottom.sh,rbottom.sh,rtop.sh}; do
			(~/Scripts/dzen/$i) &
		done
		exec xmonad
		;;
	wmfs)
		exec wmfs
		;;
	*)
		for i in {lbottom.sh,rbottom.sh,rtop.sh}; do
			(~/Scripts/dzen/$i) &
		done
		exec openbox-session
		;;
esac
