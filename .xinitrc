#!/bin/bash

xset +fp /usr/share/fonts/TTF

#xrdb -merge .Xresources

#xrandr -s 1920x1080

#unclutter -idle 2.5

#xscreensaver -no-splash &

#eval `keychain --eval id_rsa`

exec xmonad

#exec startxfce4
