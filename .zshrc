# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Oh-my-zsh
export ZSH="/Users/helen/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    docker
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export GIT_EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color

# bare repository for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ls='ls -AG'
alias l='ls -CF'
alias ll='ls -alF'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias ..='cd ..'

alias vim='nvim'

alias cowy='fortune | cowsay | lolcat'

# Paths
# GNU Make PATH
export PATH=/usr/local/opt/make/libexec/gnubin:$PATH
# Arduino avr-gcc
export PATH=/usr/local/bin:/usr/local/avr/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:/Users/helen/ch-darwin-amd64"
