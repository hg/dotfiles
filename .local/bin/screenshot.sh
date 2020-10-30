#!/bin/sh

dir="$HOME/img/shots"
out="$dir/$(date -Iseconds).png"

mkdir --parents "$dir"

shotgun --format png --geometry $(hacksaw) - |
  tee "$out" |
  xclip -selection clipboard -t image/png
