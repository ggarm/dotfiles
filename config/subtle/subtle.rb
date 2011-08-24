#
# Author::  Dipilibupap dipilibupap@gmail.com / Christoph Kappel <unexist@dorfelite.net>
# Version:: $Id$
# License:: GNU GPL

# == Options {{{
#
# Following options change behaviour and sizes of the window manager:
#
# Border size in pixel of the windows

# Window move/resize steps in pixel per keypress
set :step, 2

# Window screen border snapping
set :snap, 10

# Default starting gravity for windows (0 = gravity of last client)
set :gravity, :center

# Make transient windows urgent
set :urgent, false

# Honor resize size hints globally
set :resize, false

# Screen strut for e.g. other panels (left, right, top, bottom)

# Font string either take from e.g. xfontsel or use xft
set :font, "xft:Monaco:pixelsize=11"

# Space around windows
# set :space, 0

# Panel size padding (left, right, top, bottom)

# Separator between sublets
set :separator, "• "

# Outline border size in pixel of panel items
#set :outline, 1

# Set the WM_NAME of subtle (Java quirk)
# set :wmname, "LG3D"
#
# }}}

# == Screen {{{
#
# Generally subtle comes with two panels per screen, one on the top and one at
# the bottom. Each panel can be configured with different panel items and
# sublets screen wise. The default config uses top panel on the first screen
# only, it's up to the user to enable the bottom panel or disable either one
# or both.

# === Properties
#
# [*stipple*]    This property adds a stipple pattern to both screen panels.
#
#                Example: stipple "~/stipple.xbm"
#                         stipple Subtlext::Icon.new("~/stipple.xbm")
#
# [*top*]        This property adds a top panel to the screen.
#
#                Example: top [ :views, :title ]
#
# [*bottom*]     This property adds a bottom panel to the screen.
#
#                Example: bottom [ :views, :title ]

#
# Following items are available for the panels:
#
# [*:views*]     List of views with buttons
# [*:title*]     Title of the current active window
# [*:tray*]      Systray icons (Can be used only once)
# [*:keychain*]  Display current chain (Can be used only once)
# [*:sublets*]   Catch-all for installed sublets
# [*:sublet*]    Name of a sublet for direct placement
# [*:spacer*]    Variable spacer (free width / count of spacers)
# [*:center*]    Enclose items with :center to center them on the panel
# [*:separator*] Insert separator
#
# Empty panels are hidden.
#
# === Links
#
# http://subforge.org/projects/subtle/wiki/Multihead
# http://subforge.org/projects/subtle/wiki/Panel
#

screen 1 do
  top    [:views, :separator, :title, :center,  :clock, :separator, :battery, :separator, :cpu, :separator, :wifi, :separator, :center, :spacer, :tray, :mpd]
#  bottom [:center, :smpd, :center, :spacer, :clock, :separator, :volume, :tray]
end

# }}}

# == Color: {{{
#
# Colors directly define the look of subtle, valid values are:
#
# [*hexadecimal*] #0000ff
# [*decimal*]     (0, 0, 255)
# [*names*]       blue
#
# Whenever there is no valid value for a color set - subtle will use a default
# one. There is only one exception to this: If no background color is given no
# color will be set. This will ensure a custom background pixmap won't be
# overwritten.
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Themes

#
# == Colors
#


style :title do
  padding     1, 1, 1, 1 
  foreground  "#F9A519"
  background  "#151515"
end

style :focus do
  padding     1, 4, 1, 4
 foreground  "#757575"
  background "#151515"
  border_bottom "#FF8272", 2
end

style :urgent do
  padding     1, 3, 0, 3
  foreground  "#FF5555"
  background  "#DDDDDD"
end

style :occupied do
  padding     1, 4, 1, 4
 foreground  "#FF8272"
  background  "#151515"
end

style :views do
  padding     1, 4, 1, 4
  foreground  "#737373"
  background  "#151515"
end

style :sublets do
  padding     1, 1, 1, 1
  border      "#151515", 2
  foreground  "#757575"
  background  "#151515"
end

style :separator do
  padding     1, 1, 1, 1
  background  "#151515"
  foreground  "#757575"
end

style :clients do
  active      "#C5C5C5", 2
  inactive    "#151515", 2
  margin      0
end

style :subtle do
  padding     0, 0, 0, 0
  panel       "#151515"
  stipple     "#222222"
end

# }}}

# == Gravities {{{
#
# http://subforge.org/projects/subtle/wiki/Gravity
#

gravity :top_left,       [   0,   0,  50,  50 ]
gravity :top_left66,     [   0,   0,  50,  66 ]
gravity :top_left33,     [   0,   0,  50,  34 ]

gravity :top,            [   0,   0, 100,  50 ]
gravity :top75,          [   0,   0, 100,  75 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,  50,  33, 100 ]

gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]
gravity :bottom_left25,  [   0,  75,  50,  25 ]

gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]
gravity :bottom_right25, [  50,  75,  50,  25 ]

gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

gravity :dia_toolbox,    [   0,   0,  15, 100 ]
gravity :dia_window,     [  15,   0,  85, 100 ]
# }}}

# == Grabs {{{
#
# Grabs are keyboard and mouse actions within subtle, every grab can be
# assigned either to a key and/or to a mouse button combination. A grab
# consists of a chain and an action.
#
# === Finding keys
#
# The best resource for getting the correct key names is
# */usr/include/X11/keysymdef.h*, but to make life easier here are some hints
# about it:
#
# * Numbers and letters keep their names, so *a* is *a* and *0* is *0*
# * Keypad keys need *KP_* as prefix, so *KP_1* is *1* on the keypad
# * Strip the *XK_* from the key names if looked up in
#   /usr/include/X11/keysymdef.h
# * Keys usually have meaningful english names
# * Modifier keys have special meaning (Alt (A), Control (C), Meta (M),
#   Shift (S), Super (W))
#
# === Chaining
#
# Chains are a combination of keys and modifiers to one or a list of keys
# and can be used in various ways to trigger an action. In subtle, there are
# two ways to define chains for grabs:
#
#   1. *Default*: Add modifiers to a key and use it for a grab
#
#      *Example*: grab "W-Return", "urxvt"
#
#   2. *Chain*: Define a list of grabs that need to be pressed in order
#
#      *Example*: grab "C-y Return", "urxvt"
#
# ==== Mouse buttons
#
# [*B1*] = Button1 (Left mouse button)
# [*B2*] = Button2 (Middle mouse button)
# [*B3*] = Button3 (Right mouse button)
# [*B4*] = Button4 (Mouse wheel up)
# [*B5*] = Button5 (Mouse wheel down)
#
# ==== Modifiers
#
# [*A*] = Alt key
# [*C*] = Control key
# [*M*] = Meta key
# [*S*] = Shift key
# [*W*] = Super (Windows) key
#
# === Action
#
# An action is something that happens when a grab is activated, this can be one
# of the following:
#
# [*symbol*] Run a subtle action
# [*string*] Start a certain program
# [*array*]  Cycle through gravities
# [*lambda*] Run a Ruby proc
#
# === Example
#
# This will create a grab that starts a urxvt when Alt+Enter are pressed:
#
#   grab "A-Return", "urxvt"
#   grab "C-a c",    "urxvt"
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4
grab "W-S-5", :ViewJump5
grab "W-S-6", :ViewJump6


# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4
grab "W-5", :ViewSwitch5
grab "W-6", :ViewSwitch6

# Select next and prev view */
grab "W-Left",  :ViewPrev
grab "W-Right", :ViewNext

# Move mouse to screen1, screen2, ...
# grab "W-A-1", :ScreenJump1
# grab "W-A-2", :ScreenJump2
# grab "W-A-3", :ScreenJump3
# grab "W-A-4", :ScreenJump4
# grab "W-A-5", :ScreenJump5


# Multimedia Keys
 grab "XF86AudioPlay", "mpc toggle" 
 grab "XF86AudioNext", "mpc next" 
 grab "XF86AudioPrev", "mpc prev" 
 grab "XF86AudioStop", "mpc stop" 

 grab "XF86Mail", "thunderbird"
 grab "XF86HomePage", "opera"

 grab "XF86AudioRaiseVolume", "amixer -q set 'PCM' 2+"
 grab "XF86AudioLowerVolume", "amixer -q set 'PCM' 2-"
 grab "XF86AudioMute"       , "amixer -q set 'Master' toggle"


# Force reload of config and sublets
grab "W-S-r", :SubtleReload
# Force restart of subtle
grab "W-S-C-r", :SubtleRestart

# Quit subtle
grab "W-S-q", :SubtleQuit

# Move current window
grab "A-B1", :WindowMove

# Resize current window
grab "A-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
# grab "W-s", :WindowStick

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-h",  :WindowLeft
grab "W-j",  :WindowDown
grab "W-k",    :WindowUp
grab "W-l", :WindowRight

# Kill current window
grab "A-F4", :WindowKill

# Cycle between given gravities
# grab "W-KP_7", [ :top_left,     :top_left66,     :top_left33     ]
# grab "W-KP_8", [ :top,          :top66,          :top33          ]
# grab "W-KP_9", [ :top_right,    :top_right66,    :top_right33    ]
# grab "W-KP_4", [ :left,         :left66,         :left33         ]
# grab "W-KP_5", [ :center,       :center66,       :center33       ]
# grab "W-KP_6", [ :right,        :right66,        :right33        ]
# grab "W-KP_1", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
# grab "W-KP_2", [ :bottom,       :bottom66,       :bottom33       ]
# grab "W-KP_3", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# In case no numpad is available e.g. on notebooks
grab "W-q", [ :top_left,     :top_left66,     :top_left33     ]
grab "W-w", [ :top,          :top66,          :top33          ]
grab "W-e", [ :top_right,    :top_right66,    :top_right33    ]
grab "W-a", [ :left,         :left66,         :left33         ]
grab "W-s", [ :center,       :center66,       :center33       ]
grab "W-d", [ :right,        :right66,        :right33        ]
#
# QUERTZ
#grab "W-y", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
# QWERTY
grab "W-z", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
grab "W-x", [ :bottom,       :bottom66,       :bottom33       ]
grab "W-c", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# Exec programs
grab "W-t", "urxvt" 
grab "W-n", "urxvt -e ncmpcpp"

# layouts

grab "A-j", :LayoutNext
grab "A-k", :LayoutPrev
grab "A-g", :LayoutSetGravity
grab "A-space", :LayoutSetNone


# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

##Launcher

begin
  require "#{ENV["HOME"]}/.config/subtle/subtle-contrib/launcher.rb"
  # Set fonts
   Subtle::Contrib::Launcher.fonts = [
    "xft:Monaco:pixelsize=100:antialias=true",
     "xft:Monaco:pixelsize=20:antialias=true" 
  ]

Subtle::Contrib::Launcher.paths = [
     "/usr/bin"
   ]
   
  rescue LoadError => error
    puts error
 end
 
  grab "A-p" do
    Subtle::Contrib::Launcher.run
 end

##Selector


begin
   require "#{ENV["HOME"]}/.config/subtle/subtle-contrib/selector.rb" 
 
   # Set font
   Subtle::Contrib::Selector.font = "xft:DejaVu Sans Mono:pixelsize=40:antialias=true" 
 rescue LoadError => error
   puts error
end

grab "A-Tab" do
 Subtle::Contrib::Selector.run
end


## Scratchpad

# Scratchpad
 grab "W-y" do
 if((c = Subtlext::Client["scratch"]))
 c.toggle_stick
 c.focus
 elsif((c = Subtlext::Subtle.spawn("urxvt -name scratch")))
 c.tags = []
 c.flags = [ :stick ]
end
end 

# }}}

# == Tags {{{
#
# Tags are generally used in subtle for placement of windows. This placement is
# strict, that means that - aside from other tiling window managers - windows
# must have a matching tag to be on a certain view. This also includes that
# windows that are started on a certain view will not automatically be placed
# there.
#
# There are to ways to define a tag:
#
# === Simple
#
# The simple way just needs a name and a regular expression to just handle the
# placement:
#
# Example:
#
#  tag "terms", "terms"
#
# === Extended
#
# Additionally tags can do a lot more then just control the placement - they
# also have properties than can define and control some aspects of a window
# like the default gravity or the default screen per view.
#
# Example:
#
#  tag "terms" do
#    match   "xterm|[u]?rxvt"
#    gravity :center
#  end
#
# === Default
#
# Whenever a window has no tag it will get the default tag and be placed on the
# default view. The default view can either be set by the user with adding the
# default tag to a view by choice or otherwise the first defined view will be
# chosen automatically.
#
# === Properties
#
# [*float*]     This property either sets the tagged client floating or prevents
#               it from being floating depending on the value.
#
#               Example: float true
#
# [*full*]      This property either sets the tagged client to fullscreen or
#               prevents it from being set to fullscreen depending on the value.
#
#               Example: full true
#
# [*geometry*]  This property sets a certain geometry as well as floating mode
#               to the tagged client, but only on views that have this tag too.
#               It expects an array with x, y, width and height values whereas
#               width and height must be >0.
#
#               Example: geometry [100, 100, 50, 50]
#
# [*gravity*]   This property sets a certain to gravity to the tagged client,
#               but only on views that have this tag too.
#
#              Example: gravity :center
#
# [*match*]    This property adds matching patterns to a tag, a tag can have
#              more than one. Matching works either via plaintext, regex
#              (see man regex(7)) or window id. Per default tags will only
#              match the WM_NAME and the WM_CLASS portion of a client, this
#              can be changed with following possible values:
#
#              [*:name*]      Match the WM_NAME
#              [*:instance*]  Match the first (instance) part from WM_CLASS
#              [*:class*]     Match the second (class) part from WM_CLASS
#              [*:role*]      Match the window role
#
#              Example: match :instance => "urxvt"
#                       match [:role, :class] => "test"
#                       match "[xa]+term"
#
# [*exclude*]  This property works exactly the same way as *match*, but it
#              excludes clients that match from this tag. That can be helpful
#              with catch-all tags e.g. for console apps.
#
#              Example: exclude :instance => "irssi"
#
# [*resize*]   This property either enables or disables honoring of client
#              resize hints and is independent of the global option.
#
#              Example: resize true
#
# [*stick*]    This property either sets the tagged client to stick or prevents
#              it from being set to stick depending on the value. Stick clients
#              are visible on every view.
#
#              Example: stick true
#
# [*type*]     This property sets the [[Tagging|tagged]] client to be treated
#              as a specific window type though as the window sets the type
#              itself. Following types are possible:
#
#              [*:desktop*]  Treat as desktop window (_NET_WM_WINDOW_TYPE_DESKTOP)
#              [*:dock*]     Treat as dock window (_NET_WM_WINDOW_TYPE_DOCK)
#              [*:toolbar*]  Treat as toolbar windows (_NET_WM_WINDOW_TYPE_TOOLBAR)
#              [*:splash*]   Treat as splash window (_NET_WM_WINDOW_TYPE_SPLASH)
#              [*:dialog*]   Treat as dialog window (_NET_WM_WINDOW_TYPE_DIALOG)
#
#              Example: type :desktop
#
# [*urgent*]   This property either sets the tagged client to be urgent or
#              prevents it from being urgent depending on the value. Urgent
#              clients will get keyboard and mouse focus automatically.
#
#              Example: urgent true
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#

# Simple tags
#tag "terms",   "xterm|[u]?rxvt|cmus"
# tag "flash", "<unknown>|exe|operapluginwrapper|npviewer.bin"
# tag "browser", "opera|firefox|chromium"
tag "filemanager", "pcmanfm|thunar"
#tag "fooz", "pcmanfm"



# Placement
tag "terms" do
  match "xterm|[u]?rxvt"
  gravity :center66
end

tag "vim" do
  match "gvim"
  gravity :center
end

tag "browser" do
	match   "opera|uzbl|luakit|firefox|navigator|chromium"
	gravity :center
end

tag "media" do
	match   "[gs]?mplayer|vlc"
	float   true
	stick   true
end

tag "office" do
	match   "libreoffice"
end

tag "sublime-text" do
	match  "sublime-text"
	gravity :left
	resize true
end

tag "mirage" do
	match  "mirage"
	gravity :center
	resize true
end

tag "filemanager" do
	match  "thunar|pcmanfm"
	gravity :center
	resize true
end


tag "fixed" do
	geometry [ 10, 10, 100, 100 ]
	stick    true
end

tag "resize" do
	match  "urxvt|gvim"
	resize true
end

tag "gravity" do
	gravity :center
end

# Modes
tag "stick" do
	match "mplayer"
	float true
	stick true
end

tag "float" do
	match "display"
	float true
end

#GIMP

# Gimp
tag "gimp_image" do
	match :role => "gimp-image-window"
	gravity :gimp_image
end

tag "gimp_toolbox" do
	match :role => "gimp-toolbox$"
	gravity :gimp_toolbox
end

tag "gimp_dock" do
	match :role => "gimp-dock"
	gravity :gimp_dock
end

#
# }}}

# == Views {{{
#
# Views are the virtual desktops in subtle, they show all windows that share a
# tag with them. Windows that have no tag will be visible on the default view
# which is the view with the default tag or the first defined view when this
# tag isn't set.
#
# Like tags views can be defined in two ways:
#
# === Simple
#
# The simple way is exactly the same as for tags:
#
# Example:
#
#   view "terms", "terms"
#
# === Extended
#
# The extended way for views is also similar to the tags, but with fewer
# properties.
#
# Example:
#
#  view "terms" do
#    match "terms"
#    icon  "/usr/share/icons/icon.xbm"
#  end
#
# === Properties
#
# [*match*]      This property adds a matching pattern to a view. Matching
#                works either via plaintext or regex (see man regex(7)) and
#                applies to names of tags.
#
#                Example: match "terms"
#
# [*dynamic*]    This property hides unoccupied views, views that display no
#                windows.
#
#                Example: dynamic true
#
# [*icon*]       This property adds an icon in front of the view name. The
#                icon can either be path to an icon or an instance of
#                Subtlext::Icon.
#
#                Example: icon "/usr/share/icons/icon.xbm"
#                         icon Subtlext::Icon.new("/usr/share/icons/icon.xbm")
#
# [*icon_only*]  This property hides the view name from the view buttons, just
#                the icon will be visible.
#
#                Example: icon_only true
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#

iconpath = "#{ENV["HOME"]}/.config/subtle/icons"

view "web" do
	match    "browser"
	dynamic false
	icon     "#{iconpath}/world.xbm"
end

view "term" do
	match    "terms"
	icon     "#{iconpath}/terminal.xbm"
	#  icon_only true
end

view "fm" do
	match    "filemanager|default"
	icon     "#{iconpath}/tag.xbm"
	dynamic true
	#  icon_only true
end

view "media" do
	match    "media"
	icon     "#{iconpath}/quote.xbm"
end

view "work" do
	match    "gimp*|office|eclipse"
	icon     "#{iconpath}/pencil.xbm"
end

view "else" do
	icon     "#{iconpath}/bug.xbm"
end

# }}}

# == Sublets {{{
#
# Sublets are Ruby scripts that provide data for the panel and can be managed
# with the sur script that comes with subtle.
#
# === Example
#
#  sur install clock
#  sur uninstall clock
#  sur list
#
# === Configuration
#
# All sublets have a set of configuration values that can be changed directly
# from the config of subtle.
#
# There are three default properties, that can be be changed for every sublet:
#
# [*interval*]    Update interval of the sublet
# [*foreground*]  Default foreground color
# [*background*]  Default background color
#
# sur can also give a brief overview about properties:
#
# === Example
#
#   sur config clock
#
# The syntax of the sublet configuration is similar to other configuration
# options in subtle:
#
# === Example
#
#  sublet :clock do
#    interval      30
#    foreground    "#eeeeee"
#    background    "#000000"
#    format_string "%H:%M:%S"
#  end
#
#  === Link
#
# http://subforge.org/projects/subtle/wiki/Sublets
#

set :separator, ">>"

sublet :wifi do
	icon_fg "#FFFFFF"
end

sublet :cpu do
	icon_fg "#A6E22E"
end

sublet :battery do
	icon_fg "#F92672"
end

sublet :temp do 
	icon_fg "#FD971F"
end

sublet :volume do
	icon_fg "#FD971F"
	foreground "#93d44f"
end



sublet :clock do
	format_string "%H:%M"
	icon_fg "#777777"
	foreground "#ff6565"
end

col1 = Subtlext::Color.new("#4682B4")                         
col2 = Subtlext::Color.new("#DBDCDC")                       
col3 = Subtlext::Color.new("#FA3939")                       
col4 = Subtlext::Color.new("#00ffff")                       
col5 = Subtlext::Color.new("#0000ff")                       

sublet :mpd do
	foreground "#DBDCDC"
	icon_fg "#757575"
	#   format_string "%note% #{col1}%artist% - #{col2}%album% - #{col3}%title%"
	format_string "%note% #{col1}%artist% - #{col3}%title%"
end

# }}}

# == Hooks {{{
#
# And finally hooks are a way to bind Ruby scripts to a certain event.
#
# Following hooks exist so far:
#
# [*:client_create*]    Called whenever a window is created
# [*:client_configure*] Called whenever a window is configured
# [*:client_focus*]     Called whenever a window gets focus
# [*:client_kill*]      Called whenever a window is killed
#
# [*:tag_create*]       Called whenever a tag is created
# [*:tag_kill*]         Called whenever a tag is killed
#
# [*:view_create*]      Called whenever a view is created
# [*:view_configure*]   Called whenever a view is configured
# [*:view_jump*]        Called whenever the view is switched
# [*:view_kill*]        Called whenever a view is killed
#
# [*:tile*]             Called on whenever tiling would be needed
# [*:reload*]           Called on reload
# [*:start*]            Called on start
# [*:exit*]             Called on exit
#
# === Example
#
# This hook will print the name of the window that gets the focus:
#
#   on :client_focus do |c|
#     puts c.name
#   end
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Hooks
#

# vim:ts=2:bs=2:sw=2:et:fdm=marker

#autostart

#}}}

