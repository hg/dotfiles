# .bashrc

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f /etc/bash.bashrc ]] && source /etc/bash.bashrc

[[ -d /usr/share/fzf ]] && {
  . /usr/share/fzf/completion.bash
  . /usr/share/fzf/key-bindings.bash
}

# disable flow control
stty -ixon

# cd by typing the directory name
shopt -s autocd

# fix minor typos in `cd` arguments
shopt -s cdspell

# infinite history & remove duplicates
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export HISTCONTROL=ignoredups
export HISTFILESIZE=
export HISTSIZE=

# command prompt
[[ -f /usr/share/git/completion/git-prompt.sh ]] &&
  source /usr/share/git/completion/git-prompt.sh

_last_exit_status() {
  local status=$?
  [[ $status != 0 ]] && echo -ne " ⟨\e[1;31m$status\e[0m⟩ "
}
PS1='\n\[\e[1;34m\]\u@\H\e[0;33m\]$(__git_ps1 " (%s)") \[\e[1;37m\]\w\[\e[0m\]$(_last_exit_status)\n\$ '

# man colors
man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# less colors
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# aliases
alias my-ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias php-server='XDEBUG_CONFIG=idekey="$(basename "$(realpath .)")" php -S 127.0.0.1:8080'
alias ls='ls --color=auto --classify'
alias dotfiles='/usr/bin/git --git-dir=$HOME/src/personal/dotfiles --work-tree=$HOME'
alias we='curl --compressed wttr.in/49.96,82.62?QAFM'
alias ip='ip -c'
alias cp='cp --reflink=auto'
alias ssh='TERM=xterm-256color ssh'

