### EXPORT ###
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths
set fish_greeting                      # Supresses fish's intro message
set TERM "screen-256color"              # Sets the terminal type
set EDITOR "lvim"                      # $EDITOR use nvim in terminal
set VISUAL "lvim"                      # $VISUAL use nvim in GUI mode
set PATH /usr/local/opt/make/libexec/gnubin /usr/local/bin /usr/local/avr/bin $PATH /Users/dawei/ch-darwin-amd64 /usr/local/sbin /nix

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

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

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
	while read -l input
		echo $input | awk '{print $'$argv[1]'}'
	end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
	sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
	tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
	head -$number
end
### END OF FUNCTIONS ###


### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias nvim='lvim'
alias vim='lvim'
alias nn='lvim'

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

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

export LUA_PATH='/usr/local/Cellar/luarocks/3.6.0/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/helen/.luarocks/share/lua/5.4/?.lua;/Users/helen/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;./?.so;/Users/helen/.luarocks/lib/lua/5.4/?.so'
export PATH='/Users/helen/.luarocks/bin:/usr/local/opt/make/libexec/gnubin:/usr/local/bin:/usr/local/avr/bin:/Users/helen/.local/bin:/Users/helen/Applications:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/Cellar/python@3.9/3.9.0_1/bin:/usr/local/opt/llvm/bin/:/Library/Apple/usr/bin:/Library/TeX/texbin:/Applications/kitty.app/Contents/MacOS:/Users/helen/ch-darwin-amd64:/usr/local/sbin'

# Set the GOPROXY environment variable
export GOPROXY=https://goproxy.io,direct
# Set environment variable allow bypassing the proxy for specified repos (optional)
export GOPRIVATE=git.mycompany.com,github.com/my/private
