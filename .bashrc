#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias la='ls -A'
alias l='ls -CF'
alias ll='ls -alF'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias ..='cd ..'

alias vim='nvim'
export EDITOR=nvim
export TERM=xterm-256color
export VISUAL=nvim

export PATH="$PATH:/Users/helen/ch-darwin-amd64"
