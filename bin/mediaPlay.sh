#!/bin/sh
#
# Exec mpd and mpdcron if not currently running

if [[ -n $(pidof mpd) ]]; then
	/usr/bin/mpc -q toggle;
else
	mpd;
	sleep 1;
	mpdcron;
	/usr/bin/mpc -q toggle;
fi





