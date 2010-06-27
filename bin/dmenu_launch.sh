#!/bin/sh

if [ -f $HOME/.dmenurc ]; then
  . $HOME/.dmenurc
else
  DMENU='dmenu -i'
fi

TERMI='urxvt -e dash -lic'
CACHE="$HOME/.dmenu_cache_recent"

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
