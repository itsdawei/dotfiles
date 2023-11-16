set -U fish_user_paths /usr/local/opt/make/libexec/gnubin /usr/local/bin /usr/local/avr/bin /usr/local/sbin $HOME/.local/bin $HOME/Applications
set TERM "screen-256color"             # Sets the terminal type
set PYTHONPATH = /usr/local/bin $PYTHONPATH
set JAVA_HOME = /usr/bin/java
set EDITOR "nvim"                      # $EDITOR use nvim in terminal
set VISUAL "nvim"                      # $VISUAL use nvim in GUI mode

set -U FZF_TMUX 1
set -U FZF_ENABLE_OPEN_PREVIEW 1

function fish_greeting
    if test (random 1 128) = 1
        pokemon-colorscripts -r --no-title -s
    else
        pokemon-colorscripts -r --no-title
    end
end

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### FUNCTIONS ###
# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
	set count (count $argv | tr -d \n)
	if test "$count" = 2; and test -d "$argv[1]"
		set from (echo $argv[1] | trim-right /)
		set to (echo $argv[2])
				command cp -r $from $to
	else
		command cp $argv
	end
end
### END OF FUNCTIONS ###


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

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dawei/google-cloud-sdk/path.fish.inc' ]; . '/Users/dawei/google-cloud-sdk/path.fish.inc'; end
