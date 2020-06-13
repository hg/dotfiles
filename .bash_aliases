alias my-ip='dig +short myip.opendns.com @resolver1.opendns.com'

alias php-server='XDEBUG_CONFIG=idekey="$(basename "$(realpath .)")" php -S 127.0.0.1:8080'

alias ls='ls --color=auto --classify'

alias dotfiles='/usr/bin/git --git-dir=$HOME/src/personal/dotfiles --work-tree=$HOME'
