#!/usr/bin/bash
# vim: sts=2 sw=2 et

# custom aliases
[[ -f ~/.bashrc       ]] && . ~/.bashrc
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# local bin
export PATH=$HOME/.local/bin:$PATH

# Go
#export GOROOT=$HOME/.go
#export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/src/go

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

