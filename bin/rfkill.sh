#!/bin/sh

sudo rmmod iwl4965;
sudo modprobe iwl4965;

#if [ -f /var/run/daemons/wpa_auto ]; then
#  sudo /etc/rc.d/wpa_auto stop
#else
#  sudo /etc/rc.d/wpa_auto start
#fi
