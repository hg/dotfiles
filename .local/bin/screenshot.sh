#!/bin/sh

dir="$HOME/img/shots"
out="$dir/$(date -Iseconds).png"

mkdir --parents "$dir"

maim --select |
  tee "$out" |
  xclip -selection clipboard -t image/png
