#!/bin/sh

echo "^ca(1,thunar $HOME/Downloads/Completed/)\
	^fg(#bc61a3)[rtorrent]^fg()\
	- ^fg(#FF8700)$1^fg()\
	- ^fg(#44FF44)Download completed.^ca()" | 
		dzen2 -y 0 -fn 'Monaco-10' -p 30 -fg '#999999' -bg '#080808';
