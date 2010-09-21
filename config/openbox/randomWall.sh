#!/bin/sh
#
# Set a random Wallpaper from the Walls dir.

_wallpaperdir="$HOME/Walls";
_numWalls=`nocope ls "$_wallpaperdir" | wc -l`

_random="$RANDOM"
#from fbsetbg code
_wallNumber=`expr $_random % $_numWalls + 1`

wallpaper="$_wallpaperdir/`nocope ls \"$_wallpaperdir\"|sed -n ${_wallNumber}p`"

#use feh
feh --bg-scale $wallpaper
