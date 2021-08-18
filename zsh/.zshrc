export EDITOR=nvim
export VISUAL=nvim
export TERM=screen-256color

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'
alias nn='nvim'

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# switch between shells
alias tobash="chsh -s /bin/bash && echo 'Now log out.'"
alias tozsh="chsh -s /bin/zsh && echo 'Now log out.'"
alias tofish="chsh -s /usr/local/bin/fish && echo 'Now log out.'"

# cow says
alias cowsays='fortune | cowsay | lolcat'

# thefuck
thefuck --alias | source


# Paths
# GNU Make PATH
export PATH=/usr/local/opt/make/libexec/gnubin:$PATH
# Arduino avr-gcc
export PATH=/usr/local/bin:/usr/local/avr/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:/Users/helen/ch-darwin-amd64"

eval "$(starship init zsh)"
