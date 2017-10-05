#!/bin/bash

xset -b

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x '$f' ] && . '$f'
  done
  unset f
fi

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

eval $(ssh-agent)

xbindkeys &
volnoti &
xrdb $HOME/.Xresources &
xsetroot -solid "#343C4B" &
xscreensaver -nosplash &
xmobar $HOME/.xmonad/mobar.conf &

exec xmonad
