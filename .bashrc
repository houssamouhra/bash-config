# Only run the rest of this file in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# XDG base directory
export XDG_BIN_HOME="$HOME/.local/bin"

# PATH setup
case ":$PATH:" in
*":$XDG_BIN_HOME:"*) ;;
*) export PATH="$XDG_BIN_HOME:$PATH" ;;
esac

# Default editor and pager
export EDITOR=vim
export VISUAL=$EDITOR
export PAGER=less
export MANPAGER=$PAGER
export GPG_TTY="$(tty 2>/dev/null)"

# History
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
shopt -s checkwinsize
shopt -s dirspell

PROMPT_COMMAND="history -a"

# ls Colors
test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)"

# Aliases
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls --color=auto -p'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -lah'
alias lt='ls -ltrh'

alias update='sudo apt update && sudo apt upgrade -y'

# Extract most common archives with one command
extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "'$1' cannot be extracted" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Git branch
git_branch() {
	local branch
	branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
	[[ -n $branch ]] && echo " ($branch)"
}

# Prompt
PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]\[\e[0;31m\]$(git_branch)\[\e[0m\]> '
