#!/bin/sh

n=`cat ~/Scripts/pacman_updates`

case $n in
	0)
		echo -n "No Updates";
		;;
	1)
		echo -n "1 Update";
		;;
	*)
		echo -n "$n Updates";
		;;
esac
