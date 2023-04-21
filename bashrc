# .bashrc

# If not running interactively, don't do anything

[[ $- != *i* ]] && return

echo "Last Login:$(last -2 -R "$(whoami)"|head -2|cut -c 20-|grep -v 'logged in')"
echo "Uptime:       $(uptime -p)"

prompt() {

	if [[ "$(whoami)" == "wirt" ]] ; then
		echo "\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[01;34m\]:$\033[00m\]"
	elif [[ "$(whoami)" == "root" ]]; then
		echo "\[\033[01;31m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[01;34m\]:#\033[00m\]"
	else
		echo "\u@\h:\w\$"
	fi
}

PS1="$(prompt) "

[[ "$(whoami)" = "root" ]] && return

# Limits recursive functions

[[ -z "$FUNCNEST" ]] && export FUNCNEST="100"

shopt -s histappend
HISTCONTROL="erasedups:ignoredups:ignorespace"
HISTSIZE="1000"
HISTFILESIZE="2000"

# Aliases

alias ls="ls -lA --color=auto"
alias grep="grep -i --color=auto"
alias ip="ip -color=auto"
alias update="sudo pacman -Syu --noconfirm && paru -Syu && flatpak update -y"
alias cdd="cd ~/Downloads"
alias cdm="cd ~/Music"
alias cdv="cd ~/Videos"
alias cdp="cd ~/Pictures"
alias cdg="cd ~/Git"
alias clean="sudo pacman -Scc && flatpak uninstall --unused"
alias diff="delta"
alias nano="micro"
alias shredf="shred -uvz"
alias top="top -e m -E m -u $(whoami)"
alias 'cd..'="cd_dir"
alias pf="printf '%s\n' *"
alias rgtagmp3="mp3gain -s i -r -e *.mp3"
alias cat="bat --style=plain"

# superuser rm -rf
function pkrm() {
	sudo rm -rf "$@";
}

# cd up specifying number
function cd_dir() {
	cd $(printf "%0.0s../" $(seq 1 $1));
}

# doas tab completion
complete -cf doas

# Coloured Man Pages
man() {
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
}

export MICRO_CONFIG_HOME="/home/wirt/.config/micro"
export MICRO_TRUECOLOR="1"
export EDITOR="micro"
export VISUAL="micro"
export PAGER="less -r"
export BAT_THEME="Dracula"
export PATH="$PATH:$HOME/.local/bin"
