# .bashrc

[[ -f /etc/bashrc ]] && source /etc/bashrc
[[ -f ~/.bash_aliases ]] && source $HOME/.bash_aliases

[[ -d /usr/share/fzf ]] && {
  . /usr/share/fzf/completion.bash
  . /usr/share/fzf/key-bindings.bash
}

# disable flow control
stty -ixon

# cd by typing the directory name
shopt -s autocd

# infinite history
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export HISTFILESIZE=
export HISTSIZE=

_last_exit_status() {
  local status=$?
  [[ $status != 0 ]] && echo -ne " ⟨\e[1;31m$status\e[0m⟩ "
}

source /usr/share/git/completion/git-prompt.sh

timer_now() { date +%s%N; }
_timer_start() { _timer_start=${_timer_start:-$(timer_now)}; }

_timer_stop() {
  local delta=$((($(timer_now) - _timer_start) / 1000))
  local us=$((delta % 1000))
  local ms=$(((delta / 1000) % 1000))
  local s=$(((delta / 1000000) % 60))
  local m=$(((delta / 60000000) % 60))
  local h=$((delta / 3600000000))

  if ((h > 0)); then
    timer_show=${h}h${m}m
  elif ((m > 0)); then
    timer_show=${m}m${s}s
  elif ((s >= 10)); then
    timer_show=${s}.$((ms / 100))s
  elif ((s > 0)); then
    timer_show=${s}.$(printf %03d $ms)s
  elif ((ms >= 100)); then
    timer_show=${ms}ms
  elif ((ms > 0)); then
    timer_show=${ms}.$((us / 100))ms
  else
    timer_show=${us}µs
  fi
  unset _timer_start
}

_set_prompt() {
  _timer_stop
  PS1='\n\[\e[1;30m\]($timer_show) \[\e[1;34m\]\u@\H\e[0;33m\]$(__git_ps1 " (%s)") \[\e[1;30m\]\w\[\e[0m\]$(_last_exit_status)\n\$ '
}

trap '_timer_start' DEBUG
PROMPT_COMMAND='_set_prompt'
