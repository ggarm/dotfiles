#!/bin/sh

if [ -f $HOME/.dmenurc ]; then
  . $HOME/.dmenurc
else
  #DMENU="dmenu -b -p >> -sb #00DDDD -sf #000000 -nb #000000 -nf #0099FF ${1+"$@"}"
  #DMENU='dmenu -b -p $ -i -fn terminus -nb #000000 -nf #ffffff -sb #1793d1 -sf #ffffff'
  DMENU='dmenu -p $ -i -fn terminus -nb #000000 -nf #b9c0af -sb #afff2f -sf #000 '

  #DMENU='dmenu -i'
fi

TERMI='urxvt -e dash -lic'
CACHE="$HOME/.config/dmenu/dmenu_cache_recent"

touch $CACHE
MOST_USED=$(LC_ALL="C"; sort $CACHE | uniq -c | sort -r | colrm 1 8)
	RUN=$( (echo "$MOST_USED"; dmenu_path | grep -vxF "$MOST_USED") | $DMENU) && \
	(echo $RUN; head -n99 $CACHE) > $CACHE.$$ && \
	mv $CACHE.$$ $CACHE

case $RUN in
    *\;) $TERMI ${RUN/;/} & ;;
    *)   $RUN &             ;;
esac

exit 0
