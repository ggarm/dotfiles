#!/bin/bash
#
# the original dget.sh script:
# (c) 2007 by Robert Manea
#
# based on dl-progress by pbrisbin
# bashed again by rich_o

# the place to download to
DIR="$HOME/Downloads"

# refresh rate on the progress bar
SECS=1

# these are passed in from uzbl
URL="$8"

# it needs to be specific to this DL instance
STAT="/tmp/dl_progress.$$"

# get filename from the url and convert some hex codes
# i hate spaces in filenames so i'm switching them
# with underscores here, adjust the first s///g if
# you want to keep the spaces
FILE="$(basename $URL | sed -r \
's/[_%]20/\_/g;s/[_%]22/\"/g;s/[_%]23/\#/g;s/[_%]24/\$/g;
s/[_%]25/\%/g;s/[_%]26/\&/g;s/[_%]28/\(/g;s/[_%]29/\)/g;
s/[_%]2C/\,/g;s/[_%]2D/\-/g;s/[_%]2E/\./g;s/[_%]2F/\//g;
s/[_%]3C/\</g;s/[_%]3D/\=/g;s/[_%]3E/\>/g;s/[_%]3F/\?/g;
s/[_%]40/\@/g;s/[_%]5B/\[/g;s/[_%]5C/\\/g;s/[_%]5D/\]/g;
s/[_%]5E/\^/g;s/[_%]5F/\_/g;s/[_%]60/\`/g;s/[_%]7B/\{/g;
s/[_%]7C/\|/g;s/[_%]7D/\}/g;s/[_%]7E/\~/g;s/[_%]2B/\+/g')"

# download
wget -O "$DIR/$FILE" --user-agent=Firefox "$URL" > $STAT 2>&1 &
pid=$!

# show progress in status bar
while ps -A | grep -q $pid; do
		COUNTER="$(ls -1 /tmp/dl_progress.* | wc -l)"
		if [ "$COUNTER" -gt "1" ];then
				declare -a perc
				for i in `ls -1 /tmp/dl_progress.*`;do
						x="$(tail -n2 $i | head -n1 | egrep -o '[0-9]{1,2}%' | sed -e 's/%//g')"
						perc[${#perc[*]}]=$x
				done

				# get smallest number in array
				# ugly but working
				for ((i=1; i<${#perc[*]};i++));do
						z=`expr $i - 1`
						if [ "${perc[$i]}" -lt "${perc[$z]}" ];then
								x=${perc[$i]}
						fi
				done
				REM=$x

		else
				REM="$(tail -n2 $STAT | head -n1 | egrep -o '[0-9]{1,2}%' | sed -e 's/%//g')"
		fi
		# this is actually shown in the status bar
		echo "set dl_stat = $COUNTER:${REM:-?}%" > $4
		sleep "$SECS"
done;
echo "set dl_stat = " > $4

rm -f "$STAT"

exit 0


