export EDITOR=nvim
export GIT_EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color

# bare repository for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

alias ls='ls -AG'
alias l='ls -CF'
alias ll='ls -alF'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias ..='cd ..'

alias vim='nvim'
alias nn='nvim'

alias cowy='fortune | cowsay | lolcat'

# ch configue for csci104
c4 () {
    argument=${1}
    ch $argument csci104
}

# Paths
# GNU Make PATH
export PATH=/usr/local/opt/make/libexec/gnubin:$PATH
# Arduino avr-gcc
export PATH=/usr/local/bin:/usr/local/avr/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:/Users/helen/ch-darwin-amd64"
if [ -e /Users/helen/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/helen/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
