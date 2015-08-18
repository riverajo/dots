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
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
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

# start the terminal emulator daemon
urxvtd -q -f -o &

# ░▒▓█ get awesome! █▓▒░
exec /usr/bin/awesome
