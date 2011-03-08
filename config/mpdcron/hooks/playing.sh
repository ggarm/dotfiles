#!/bin/sh
case $MPD_STATUS_STATE in
	play)
		TIME_ELAPSED=`expr $MPD_STATUS_ELAPSED_TIME \* 100 / $MPD_STATUS_TOTAL_TIME`
		echo "♫ ^fg(#ff8700)$MPD_SONG_TAG_ARTIST^fg() - ^fg(#6be603)$MPD_SONG_TAG_TITLE^fg()  [#$MPD_SONG_TAG_TRACK ^fg(#f8072e)$MPD_SONG_TAG_ALBUM^fg()] @$TIME_ELAPSED%" | dzen2 -y 1062 -p 3 -fn 'envy code r-10' -fg '#999999' -bg '#080808';
		;;
	"pause")
		echo "♫ ^fg(#bc61a3)Paused: ^fg(#ff8700)$MPD_SONG_TAG_ARTIST^fg() - ^fg(#6be603)$MPD_SONG_TAG_TITLE^fg()  [#$MPD_SONG_TAG_TRACK ^fg(#f8072e)$MPD_SONG_TAG_ALBUM^fg()]" | dzen2 -y 1062 -p 3 -fn 'envy code r-10' -fg '#999999' -bg '#080808';
		;;
	"stop")
		;;
esac

