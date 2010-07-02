#!/bin/sh
#notify-send -i $HOME/.icons/SONG.png "`ncmpcpp --now-playing "{%t}"`" "by `ncmpcpp --now-playing "{%a}"`"
#notify-send -t 1000 -i /usr/share/icons/sonata.png "$(ncmpcpp --now-playing "{%t}")" "by $(ncmpcpp --now-playing "{%a}")" -h string:synchronous:mpd
notify-send -u critical -i /usr/share/icons/sonata.png "$(ncmpcpp --now-playing "{%t}")" "by $(ncmpcpp --now-playing "{%a}")"

