#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x '$f' ] && . '$f'
  done
  unset f
fi

[[ -f /home/chronic/.Xresources ]] && xrdb -merge /home/chronic/.Xresources

eval $(ssh-agent)

xinput disable 9 &
xbindkeys &
volnoti &

exec xmonad
