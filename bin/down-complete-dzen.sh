#!/bin/sh

echo "^ca(1,pcmanfm $HOME/Downloads/Completed/)\
	^fg(#bc61a3)[rtorrent]^fg()\
	- ^fg(#FF8700)$1^fg()\
	- ^fg(#44FF44)Download completed.^ca()"\
	| dzen2 -y 0 -p 30 -fn 'envy code r-10' -fg '#999999' -bg '#080808';
