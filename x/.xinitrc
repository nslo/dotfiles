#!/bin/sh

# keybindings
xbindkeys &

# keyboard refresh rate
xset r rate 150 30

# set background
feh --bg-fill /tmp/wallpaper.jpg

# get rid of beeping
#xset b off

# touchpad stuff 
#synclient HorizEdgeScroll=1
#synclient VertEdgeScroll=1
#synclient TapButton1=1

# cursor for xmonad
xsetroot -cursor_name left_ptr

# numlock on
numlockx &

# compositor for transparency (urxvt)
xcompmgr &

# merge resources file (for things like terminal colors)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# system tray (not needed with i3bar)
#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --widthtype percent --width 8 --height 19 --transparent true --alpha 26 --tint 0x000000 &

# auto-mounting
udiskie -2 --tray &

# screen locking
xscreensaver -no-splash &
#light-locker --late-locking &
#xautolock -time 15 -locker slimlock &
#xautolock -time 15 -locker ~/Code/Scripts/i3lock_blur.sh &

# notification manager
dunst &

skype &

# remove this when aur package sorted out
#/usr/local/crashplan/bin/CrashPlanEngine start
~/Local/crashplan/bin/CrashPlanEngine start

#dropboxd &

#checkgmail -no_cookies &

caffeine &

# this sleep call seems to prevent the tray from not appearing
sleep 5
pasystray &

# MPD daemon start
mpd &

# launch window manager
#exec xmonad [goodbye xmonad]
(sleep 2 & urxvt -name scratchpad) &
exec i3
