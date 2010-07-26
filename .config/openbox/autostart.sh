# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# Set a background color
# xsetroot -solid "#303030"

# D-bus
if which dbus-launch >/dev/null 2>&1 && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Run XDG autostart things.  By default don't run anything desktop-specific
# See xdg-autostart --help more info
DESKTOP_ENV="OPENBOX"
#if which /usr/lib/openbox/xdg-autostart >/dev/null 2>&1; then
  #/usr/lib/openbox/xdg-autostart $DESKTOP_ENV
#fi
