#!/bin/bash
DMENU="dmenu -l 10 -fn glisp -nb #100 -nf #b9c0af -sb #000 -sf #afff2f -i -p Play:"
mpc -q play $(sed -n "s@^ *\([0-9]\+\);$(mpc -q playlist|$DMENU||echo ";;;")@\1@p" < <(mpc -q playlist|nl -s ';')) 
