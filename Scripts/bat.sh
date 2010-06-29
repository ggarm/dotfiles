#!/bin/sh

read -r str bool < /proc/acpi/battery/BAT1/state;
if [[ $str == "present:" && $bool == "no" ]]; then
#read -r str bool < cat /proc/acpi/battery/BAT1/state) != "present:	no" ]]; then
    echo 'dif';
fi

