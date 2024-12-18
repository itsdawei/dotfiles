set -U fish_user_paths /usr/local/opt/make/libexec/gnubin /usr/local/bin /usr/local/avr/bin /usr/local/sbin $HOME/.local/bin $HOME/Applications $HOME/.dotnet/tools
set TERM "screen-256color"             # Sets the terminal type
set PYTHONPATH = /usr/local/bin $PYTHONPATH
set JAVA_HOME = /usr/bin/java

set EDITOR "nvim"                      # $EDITOR use nvim in terminal
set VISUAL "nvim"                      # $VISUAL use nvim in GUI mode

function fish_greeting
    if test (random 1 128) = 1
        pokemon-colorscripts -r --no-title -s
    else
        pokemon-colorscripts -r --no-title
    end
end

### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim
alias nn='nvim'

# conda
alias ca='conda activate'

# Changing "ls" to "exa"
alias ls='exa -l --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias icat="kitty +kitten icat"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# tmux
alias jupyter-tmux='tmux new -d -s jupyter "jupyter-lab --no-browser"';
alias tas='tmux attach-session -t'

alias agenda='gcalcli agenda "$(date \'+%d\')" "$(date -d \'+1 day\' \'+%d\')"'

# minecraft docker
alias dcm='docker-compose -f minecraft.yml'

# thefuck
thefuck --alias | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
end

starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/dawei/miniconda3/bin/conda
    eval /home/dawei/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# tmux conda fix
if string length -q -- $TMUX
  eval conda deactivate && conda activate base
end

