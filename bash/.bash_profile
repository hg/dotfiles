#!/usr/bin/bash
# vim: sts=2 sw=2 et

# custom aliases
[[ -f ~/.bashrc       ]] && . ~/.bashrc
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

