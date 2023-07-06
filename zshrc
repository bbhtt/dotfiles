### .zshrc

## Display last login and uptime
#echo "Last Login:$(last -2 -R "$(whoami)"|head -2|cut -c 20-|grep -v 'logged in')"
echo "Uptime:       $(uptime -p)"

[[ "$(whoami)" == "root" ]] && return

# antigen plugin manager
#source $HOME/.local/bin/antigen.zsh
# antidote plugin manager
# needs to stay on top
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.antidote/antidote.zsh


## zsh options
# Turns on spelling correction for commands
setopt correct
# Turns on spelling correction for all arguments
setopt correctall
# Extended globbing
setopt extendedglob
# Case insensitive globbing
setopt nocaseglob
# Array expansion
setopt rcexpandparam
# Don't warn about running processes when exiting
setopt nocheckjobs
# Sort filenames numerically
setopt numericglobsort
# Append history instead of overwriting
setopt appendhistory
# Ignore duplicates
setopt histignorealldups
# Save commands are added to the history immediately
setopt inc_append_history
# Don't save commands that start with space
setopt histignorespace
# Remove superfluous blanks from each command line being added to the
# history list
setopt histreduceblanks
# Timestamps to history
setopt extended_history
# Share history between terminal sessions
setopt share_history
# Whenever the user enters a line with history expansion, don’t execute
# the line directly; instead, perform history expansion and reload the
# line into the editing buffer
setopt hist_verify
# simply type the name of a directory, and it will become the current
# directory.
setopt autocd
# https://zsh.sourceforge.io/Intro/intro_6.html
setopt autopushd
setopt pushdminus
setopt pushdsilent
setopt pushdtohome
setopt pushdignoredups
# safe rm
setopt rm_star_wait
unsetopt rm_star_silent
# https://github.com/robbyrussell/oh-my-zsh/issues/449
setopt no_nomatch
# If set, parameter expansion, command substitution and arithmetic
# expansion are performed in prompts. Substitutions within prompts do
# not affect the command status.
setopt prompt_subst

# Initiate completion module
autoload -U compinit compdef

# Check cache once every day - speeds up startup
# https://gist.github.com/ctechols/ca1035271ad134841284
for dump in $HOME/.cache/zsh/zcompdump(N.mh+24); do
  compinit -d $HOME/.cache/zsh/zcompdump
done
compinit -C -d $HOME/.cache/zsh/zcompdump

# add-zsh-hook module
autoload -Uz add-zsh-hook
# cdr module
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# VCS module
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info

# Completion menu
zstyle ':completion:*' menu select
# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# Colored completion
zstyle ':completion:*:default' list-colors '${(s.:.)LS_COLORS}'
# Automatically load new executables in $PATH
zstyle ':completion:*' rehash true
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh
# VCS info - git
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
# cdr completion menu
zstyle ':completion:*:*:cdr:*:*' menu selection
# cdr settings
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/zsh/chpwd-recent-dirs"
# Speed up pasting with zsh-syntax-highlight
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# preview directory's content with exa when completing ls
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Don't consider certain characters part of the word
WORDCHARS=${WORDCHARS//\/[&.;]}
## History
HISTFILE=$HOME/.cache/zsh/zshistory
HISTSIZE=10000
SAVEHIST=10000

## Colored man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

## Aliases
alias ls="ls -lA --color=auto"
alias grep="grep -i --color=auto"
alias ip="ip -color=auto"
alias update="sudo dnf upgrade && flatpak update -y"
alias cdd="cd ~/Downloads"
alias cdm="cd ~/Music"
alias cdv="cd ~/Videos"
alias cdp="cd ~/Pictures"
alias cdg="cd ~/Git"
alias clean="sudo dnf autoremove && sudo dnf repoquery --extras && sudo dnf clean all && flatpak uninstall --unused"
alias diff="delta"
alias nano="micro"
#alias shredf="shred -uvz"
alias top="top -e m -E m -u $(whoami)"
alias pf="printf '%s\n' *"
alias rgtagmp3="mp3gain -s i -r -e *.mp3"
alias cat="bat --style=plain"
alias rename="rn"
alias rm="trash-put"
alias yank="yank-cli -- wl-copy"

## Environment variables
export MICRO_CONFIG_HOME="/home/wirt/.config/micro"
export MICRO_TRUECOLOR="1"
export EDITOR="micro"
export VISUAL="micro"
export PAGER="less -r"
export BAT_THEME="Dracula"
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"
export npm_config_prefix="$HOME/.local"

## Prompt
#if [[ "$(whoami)" == "wirt" ]] ; then
#	PROMPT='[%F{green}%n%f %F{yellow}%~%f %F{blue}${vcs_info_msg_0_}%f]:$ '
#elif [[ "$(whoami)" == "root" ]]; then
#	PROMPT='[%F{red}%n%f %F{yellow}%~%f]:# '
#fi

# antidote plugin manager
# needs to stay below if using plugins that needs autoload compdef etc.
antidote load ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zsh_plugins.conf

## Plugins
#antigen use oh-my-zsh
# Copy current $PWD
#antigen bundle copypath
# Add keyboard shortcuts for navigating directory history and hierarchy
# Alt + Left/Right - go to previous/next directory
# Alt + Up/Down - go to parent/first child directory
#antigen bundle dirhistory
# Copy current buffer
#antigen bundle copybuffer
# Copy file to clipboard
#antigen bundle copyfile
# Extract supported files, syntax is `extract <filename>`
#antigen bundle extract
# Press escape twice to run as sudo
#antigen bundle sudo
# systemd aliases
#antigen bundle systemd
# Git aliases
#antigen bundle git
# Show alias tips
#antigen bundle akash329d/zsh-alias-finder
# Tab completion menu
#antigen bundle Aloxaf/fzf-tab
# pacman/aur helper aliases
#antigen bundle Junker/zsh-archlinux@main
# Ctrl+R tab menu history search
#antigen bundle joshskidmore/zsh-fzf-history-search
#antigen apply

# zsh-fzf-history-search is not compatible with antigen so needs to be
# loaded seperately
#source $HOME/.antigen/bundles/joshskidmore/zsh-fzf-history-search/zsh-fzf-history-search.zsh

# zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# cursor should be removed - causes it do disappear on pressing back
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)

# zsh-autosuggestions
#fpath=(/usr/share/zsh/site-functions/ $fpath)
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Ctrl+ Space
bindkey '^ ' autosuggest-accept
# https://github.com/zsh-users/zsh-autosuggestions/issues/511
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

## Terminal title
DISABLE_AUTO_TITLE="true"
echo -e "\033];[$(hostname)@$(whoami)]:$\007"

eval "$(starship init zsh)"
