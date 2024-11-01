### .zshrc

# eval "$(starship init zsh)"

[[ "$(whoami)" == "root" ]] && return

## Initial environment variables

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
touch $XDG_CACHE_HOME/zsh/zshistory

export TYPEWRITTEN_PROMPT_LAYOUT="pure"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_COLOR_MAPPINGS="primary:#ecec74;secondary:#8AFF80;accent:#FFFF80;info_negative:#FF80BF;info_positive:#8AFF80;info_neutral_1:#FF9580;info_neutral_2:#FFFF80;info_special:#80FFEA"
export TYPEWRITTEN_ARROW_SYMBOL=""

[[ -f $XDG_CONFIG_HOME/zsh/zsh_plugins.conf ]] || touch $XDG_CONFIG_HOME/zsh/zsh_plugins.conf
fpath=($XDG_CONFIG_HOME/zsh/.antidote/functions $fpath)
autoload -Uz antidote
if [[ ! $XDG_CONFIG_HOME/zsh/zsh_plugins.zsh -nt $XDG_CONFIG_HOME/zsh/zsh_plugins.conf ]]; then
  antidote bundle <$XDG_CONFIG_HOME/zsh/zsh_plugins.conf >|$XDG_CONFIG_HOME/zsh/zsh_plugins.zsh
fi

## zsh options
# Turns on spelling correction for commands
setopt correct
# Turns on spelling correction for all arguments
#setopt correctall
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
# Unset % eof
unsetopt prompt_cr prompt_sp

# Initiate completion module
autoload -Uz compinit compdef

# Check cache once every day - speeds up startup
# https://gist.github.com/ctechols/ca1035271ad134841284
for dump in $XDG_CACHE_HOME/zsh/zcompdump(N.mh+24); do
  compinit -d $XDG_CACHE_HOME/zsh/zcompdump
done
compinit -C -d $XDG_CACHE_HOME/zsh/zcompdump

# add-zsh-hook module
autoload -Uz add-zsh-hook
# cdr module
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# VCS module
autoload -Uz vcs_info

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
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh
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
zstyle ':chpwd:*' recent-dirs-file $XDG_CACHE_HOME/zsh/chpwd-recent-dirs
# Speed up pasting with zsh-syntax-highlight
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# preview directory's content with eza when completing ls
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Don't consider certain characters part of the word
WORDCHARS=${WORDCHARS//\/[&.;]}
## History
HISTFILE="$XDG_CACHE_HOME/zsh/zshistory"
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

## Functions
git() {
  if [[ $1 == "push" ]]; then
    typeset -aU args
    args=("$@")
    for ((i = 1; i <= $#args; i++)); do
      if [[ ${args[$i]} == "-f" || ${args[$i]} == "--force" ]]; then
        args[$i]="--force-with-lease"
        args+=("--force-if-includes")
      fi
    done
    set -- "${args[@]}"
    command git "$@"
  elif [[ $1 == "clone" ]]; then
    command git "$@" && cd "$(basename "$_" .git)"
  else
    command git "$@"
  fi
}

paste() {
  curl -s -F "content=<-" http://dpaste.com/api/v2/
}

## Aliases
#alias ls="lsd -lA"
alias grep="grep -i --color=auto"
alias ip="ip -color=auto"
alias update="sudo dnf upgrade -y && flatpak update -y"
alias cdd="cd ~/Downloads"
alias cdg="cd ~/Git"
alias clean="sudo dnf autoremove -y && sudo dnf repoquery --extras && sudo dnf clean all && flatpak uninstall --unused"
alias diff="delta"
alias pdiff="/usr/bin/diff"
alias pcat="/usr/bin/cat"
alias nano="micro"
#alias shredf="shred -uvz"
alias top="top -e m -E m -u $(whoami)"
alias pf="printf '%s\n' *"
alias rgtagmp3="mp3gain -s i -r -e *.mp3"
alias cat="bat --style=plain"
alias rm="trash-put"
alias yank="yank-cli -- wl-copy"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias irssi="irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi"
alias gpdiff="git difftool --tool=diff"
alias resolve="dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml -resolve"
alias pgit="/bin/git"
## Environment variables
# Needs to be hardcoded to user
export MICRO_CONFIG_HOME="/home/bbhtt/.config/micro"
alias prm="/bin/rm"

export MICRO_TRUECOLOR="1"
export EDITOR="micro"
export VISUAL="micro"
export PAGER="less -r"
export BAT_THEME="Dracula"
export PATH="$HOME/.local/bin:$XDG_DATA_HOME/npm/bin:$XDG_DATA_HOME/cargo/bin:$PATH"
export npm_config_prefix="$HOME/.local"
export npm_config_prefix="$XDG_DATA_HOME/npm"
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"
export npm_config_cache="$XDG_DATA_HOME/npm"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
export MOZBUILD_STATE_PATH="$XDG_STATE_HOME/mozbuild"
export THELOUNGE_HOME="$XDG_CONFIG_HOME/thelounge"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
# docker-compose v2 systemctl --user enable --now podman.socket
#export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

# antidote plugin manager
# needs to stay below if using plugins that needs autoload compdef etc.
source $XDG_CONFIG_HOME/zsh/zsh_plugins.zsh
# zsh-syntax-highlighting
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# cursor should be removed - causes it do disappear on pressing back
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)

# zsh-autosuggestions
#fpath=(/usr/share/zsh/site-functions/ $fpath)
#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Ctrl+ Space
bindkey '^ ' autosuggest-accept
# https://github.com/zsh-users/zsh-autosuggestions/issues/511
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

## Terminal title
DISABLE_AUTO_TITLE="true"
echo -e "\033];[$(whoami)@$(hostname)]:$\007"|tr -d '\n'

if [ -f "$(which podman 2> /dev/null)" ]; then
  podman start Archlinux > /dev/null && podman start Fedora > /dev/null
fi
