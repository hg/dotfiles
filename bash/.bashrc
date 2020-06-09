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

__exit_status() {
  status=$?
  [[ $status == 0 ]] || echo -n "$status "
}

source /usr/share/git-core/contrib/completion/git-prompt.sh

PS1='\n$(__exit_status)\[\e[1;34m\]\u@\H\e[0;33m\]$(__git_ps1 " (%s)")\e[1;30m\] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ '
