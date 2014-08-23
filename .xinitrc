#!/bin/sh

# keybindings
xbindkeys &

# set background
feh --bg-fill /tmp/wallpaper.jpg

# get rid of beeping
xset b off

# touchpad stuff 
synclient HorizEdgeScroll=1
synclient VertEdgeScroll=1
synclient TapButton1=1

# cursor for xmonad
xsetroot -cursor_name left_ptr

# merge resources file (for things like terminal colors)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# compositor for transparency (urxvt)
xcompmgr &

# system tray
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --height 18 --transparent true --alpha 0 --tint 0x000000 &

# auto-mounting
udiskie -2 --tray &

# screen locking
xautolock -time 15 -locker slimlock &

# notification manager
dunst &

# skyped starts skype; used for bitlbee
#skyped &

#dropboxd &

checkgmail -no_cookies &

# pulse doesn't initiate correctly if X starts it automatically
pulseaudio --start
sleep 5
pasystray &

# launch window manager
exec xmonad
