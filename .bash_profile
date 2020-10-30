#!/usr/bin/bash
# vim: sts=2 sw=2 et

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

if [[ "$(tty)" = "/dev/tty1" ]]; then
  #exec startx
  eval "$(ssh-agent)"
  ssh-add ~/.ssh/{id_ed25519,work}
  exec sway
fi
