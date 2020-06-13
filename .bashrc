# .bashrc

[[ -f /etc/bashrc ]] && source /etc/bashrc
[[ -f ~/.bash_aliases ]] && source $HOME/.bash_aliases

# disable flow control
stty -ixon

# cd by typing the directory name
shopt -s autocd

# infinite history
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export HISTFILESIZE=
export HISTSIZE=

__last_exit_status() {
  status=$?
  [[ $status != 0 ]] && echo -ne " ⟨\e[1;31m$status\e[0m⟩ "
}

source /usr/share/git/completion/git-prompt.sh

PS1='\n\[\e[1;34m\]\u@\H\e[0;33m\]$(__git_ps1 " (%s)") \[\e[1;30m\]\w\[\e[0m\]$(__last_exit_status)\n\$ '

