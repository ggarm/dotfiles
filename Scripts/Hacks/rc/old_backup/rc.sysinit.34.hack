#!/bin/bash
#
# /etc/rc.sysinit
# 
# Modified on 16 JUN 2010 @ 02:30
# 
# Serious hacks below
#
## Removed:
# -- minilogd; dmesg and dmesg > out.txt
# -- hooks of all kinds
# -- swap (I have none)
# -- removed hostname print, removed nisdomain if
# -- removed depmod -A and ldconfig
# -- consolefont check
# -- persistent network/cdrom generated rules
#
## Modified:
# -- HWCLOCK_PARAMS hardcoded to utc
# -- RTC_MAJOR -> assumed to be non-null value
# -- /proc/mount -> has a non-void grep
# -- mount option -O no_netdev -> removed
# -- write / to mtab -> cat /proc/mounts
# -- /etc/localtime -> removed check and 'rm -f' (cp already overwrites)
# -- /sbin/hwclock -> removed check and 'joined' --adjust
# -- random_seed -> folded variable and removed check
# -- No longer keeping {x,k,g}dm happy with xorg
# -- Setting locale with less if's
# -- [ -x /sbin/fsck] Assumed to be executable and existant
# -- [ -d /sys/class/net/lo ]; Assumed that directory exists
# -- Placed a & in the net interface and removed a print
# -- Udev -> antecipated the trigger 
# -- Udev -> removed a if in the wait
# -- Modules -> removed if's and placed a &
#

. /etc/rc.conf
. /etc/rc.d/functions

echo " "
printhl "Arch Linux\n"
printhl "${C_H2}http://www.archlinux.org"
printhl "Copyright 2002-2007 Judd Vinet"
printhl "Copyright 2007-2009 Aaron Griffin"
printhl "Distributed under the GNU General Public License (GPL)"
printsep\


# mount /proc, /sys and our RAM /dev
/bin/mount -n -t tmpfs udev /dev -o mode=0755,size=10M,nosuid
/bin/mount -n -t proc none /proc
/bin/mount -n -t sysfs none /sys

# Copy static device nodes to /dev
/bin/cp -a /lib/udev/devices/* /dev/

# left this -- rcac
/bin/dmesg -n 3

# enable rtc access
/sbin/modprobe rtc-cmos >/dev/null 2>&1
RTC_MAJOR=$(/bin/grep -w rtc /proc/devices 2>/dev/null)
RTC_MAJOR="${RTC_MAJOR%% *}"
/bin/mknod /dev/rtc0 c $RTC_MAJOR 0
/bin/ln -s /dev/rtc0 /dev/rtc

# Do a clock set here for a few reasons: -- blah, blah, whiskas saquetas -- rcac
/sbin/hwclock --hctosys --utc --noadjfile

echo > /proc/sys/kernel/hotplug

stat_busy "Starting UDev Daemon"
/sbin/udevd --daemon
  /sbin/udevadm control --property=STARTUP=1
  /sbin/udevadm trigger
  /sbin/udevadm settle
  /sbin/udevadm control --property=STARTUP=
stat_done

# Load modules from the MODULES array defined in rc.conf
		stat_busy "Loading Modules"
		for mod in "${MODULES[@]}"; do
				( /sbin/modprobe $mod ) &
		done
		stat_done

# bring up the loopback interface
(/sbin/ifconfig lo 127.0.0.1 up) &

status "Mounting Root Read-only" /bin/mount -n -o remount,ro /

FORCEFSCK=
[ -f /forcefsck ] && FORCEFSCK="-- -f"
NETFS="nonfs,nonfs4,nosmbfs,nocifs,nocodafs,noncpfs,nosysfs,noshfs,nofuse,nofuseblk,noglusterfs"

fsck_reboot() {
	echo "Automatic reboot in progress..."
	/bin/umount -a
	/bin/mount -n -o remount,ro /
	/sbin/reboot -f
	exit 0
}

	stat_busy "Checking Filesystems"
	/sbin/fsck -A -T -C -a -t $NETFS $FORCEFSCK >/dev/stdout 2>/dev/null
	fsckret=$?
	if [ ${fsckret} -gt 1 ]; then
		stat_fail
	fi
	if [ $((${fsckret}&2)) -eq 2 ]; then
		echo
		echo "********************** REBOOT REQUIRED *********************"
		echo "*                                                          *"
		echo "* The system will be rebooted automatically in 15 seconds. *"
		echo "*                                                          *"
		echo "************************************************************"
		echo
		/bin/sleep 15
		fsck_reboot
	fi
	if [ ${fsckret} -gt 1 -a ${fsckret} -ne 32 ]; then
		echo
		echo "*****************  FILESYSTEM CHECK FAILED  ****************"
		echo "*                                                          *"
		echo "*  Please repair manually and reboot. Note that the root   *"
		echo "*  file system is currently mounted read-only. To remount  *"
		echo "*  it read-write type: mount -n -o remount,rw /            *"
		echo "*  When you exit the maintenance shell the system will     *"
		echo "*  reboot automatically.                                   *"
		echo "*                                                          *"
		echo "************************************************************"
		echo
		/sbin/sulogin -p
		fsck_reboot
	fi
	stat_done

stat_busy "Mounting Local Filesystems"
/bin/mount -n -o remount,rw /
cat /proc/mounts >| /etc/mtab
# now mount all the local filesystems
/bin/mount -a -t $NETFS
stat_done

#status "Setting Hostname: $HOSTNAME" 
/bin/hostname $HOSTNAME

#status "Setting KEYMAP: $KEYMAP" 
/bin/loadkeys -q -u $KEYMAP

# End of file
# vim: set ts=2 sw=2 noet:
