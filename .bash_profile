#!/usr/bin/bash
# vim: sts=2 sw=2 et

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

if [[ "$(tty)" = "/dev/tty1" ]]; then
  pkill -u $USER ssh-agent
  eval "$(ssh-agent)"
  ssh-add ~/.ssh/{main,work}
  exec sway
fi

