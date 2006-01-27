#!/bin/sh

nitrogen --restore &

if [ `pidof urxvtd | wc -l` -lt 1 ] ; then
	urxvtd -q -f -o
wmfs -c tag 1
urxvtc -e tmux attach
fi
