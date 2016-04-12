#!/bin/sh
#
#          ██          ██   ██                 
#         ░░          ░░   ░██                 
#  ██   ██ ██ ███████  ██ ██████ ██████  █████ 
# ░░██ ██ ░██░░██░░░██░██░░░██░ ░░██░░█ ██░░░██
#  ░░███  ░██ ░██  ░██░██  ░██   ░██ ░ ░██  ░░ 
#   ██░██ ░██ ░██  ░██░██  ░██   ░██   ░██   ██
#  ██ ░░██░██ ███  ░██░██  ░░██ ░███   ░░█████ 
# ░░   ░░ ░░ ░░░   ░░ ░░    ░░  ░░░     ░░░░░  
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ joe
# ░▓ code   ▓ 
# ░▓ mirror ▓ 
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
userresources=$HOME/.Xresources
userdefaults=$HOME/.Xdefaults
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and kemaps

if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xrdb -merge $sysmodmap
fi

if [ -f $userresources ]; then
	xrdb -merge $userresources
fi

if [ -f $userdefaults ]; then
	xrdb -merge $userdefaults
fi

if [ -f $usermodmap ]; then
	xrdb -merge $usermodmap
fi
#Start urxvt deamon
urxvtd --quiet --opendisplay --fork
#Start sceensaver
/usr/bin/xscreensaver &

# ░▒▓█ get awesome! █▓▒░
exec /usr/bin/awesome
