#!/bin/sh

# stolen from here:
# https://github.com/swaywm/sway/blob/96578aa91e9856bfb3e2d79e3/contrib/grimshot
getTargetDirectory() {
  test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs &&
    . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs

  echo ${XDG_SCREENSHOTS_DIR:-${XDG_PICTURES_DIR:-$HOME}}
}

out="$(getTargetDirectory)/shots/$(date -Iseconds).png"

mkdir --parents "$(dirname "$out")"

shotgun --format png --geometry $(hacksaw) - |
  tee "$out" |
  xclip -selection clipboard -t image/png
