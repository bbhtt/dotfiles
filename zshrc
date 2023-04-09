# .zshrc

echo "Last Login:$(last -2 -R "$(whoami)"|head -2|cut -c 20-|grep -v 'logged in')"
echo "Uptime:       $(uptime -p)"

[[ "$(whoami)" = "root" ]] && return

source /usr/share/zsh/share/antigen.zsh

setopt correct
setopt correctall
setopt extendedglob
setopt nocaseglob
setopt rcexpandparam
setopt nocheckjobs
setopt numericglobsort
setopt appendhistory
setopt histignorealldups
setopt inc_append_history
setopt histignorespace
setopt histreduceblanks
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
setopt extended_history
setopt share_history
setopt hist_verify
setopt rm_star_wait
unsetopt rm_star_silent
setopt prompt_subst

autoload -U promptinit && promptinit
autoload -U compinit compdef && compinit -d $HOME/.cache/zsh/zcompdump
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

WORDCHARS=${WORDCHARS//\/[&.;]}
HISTFILE=$HOME/.cache/zsh/zshistory
HISTSIZE=10000
SAVEHIST=10000

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

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

export MICRO_CONFIG_HOME="/home/wirt/.config/micro"
export MICRO_TRUECOLOR="1"
export EDITOR="micro"
export VISUAL="micro"
export PAGER="less -r"
export BAT_THEME="Dracula"
export PATH="$PATH:$HOME/.local/bin"

if [[ "$(whoami)" == "wirt" ]] ; then
	PROMPT='[%F{green}%n%f %F{yellow}%~%f %F{blue}${vcs_info_msg_0_}%f]:$ '
elif [[ "$(whoami)" == "root" ]]; then
	PROMPT='[%F{red}%n%f %F{yellow}%~%f]:# '
fi

antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle copypath
antigen bundle dirhistory
antigen bundle copybuffer
antigen bundle copyfile
antigen bundle sudo
antigen bundle git
antigen bundle akash329d/zsh-alias-finder
antigen bundle Aloxaf/fzf-tab
antigen bundle Junker/zsh-archlinux@main
antigen bundle mollifier/cd-gitroot
antigen bundle joshskidmore/zsh-fzf-history-search
antigen apply

source $HOME/.antigen/bundles/joshskidmore/zsh-fzf-history-search/zsh-fzf-history-search.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]=underline

fpath=(/usr/share/zsh/site-functions/ $fpath)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

DISABLE_AUTO_TITLE="true"
echo -e "\033];[$(hostname)@$(whoami)]:$\007"
