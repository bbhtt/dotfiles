### .zshrc

[[ "$(whoami)" == "root" ]] && return

eval "$(starship init zsh)"

## Initial environment variables

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_BIN_HOME=$HOME/.local/bin

mkdir -p $XDG_CACHE_HOME/zsh $XDG_CONFIG_HOME/micro $XDG_CONFIG_HOME/git $XDG_BIN_HOME
touch $XDG_CACHE_HOME/zsh/zshistory

[ ! -f $XDG_CONFIG_HOME/zsh/zsh_plugins.conf ] && curl -s -o $XDG_CONFIG_HOME/zsh/zsh_plugins.conf \
  https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/zsh_plugins.conf

[ ! -f $XDG_CONFIG_HOME/starship.toml ] && curl -s -o $XDG_CONFIG_HOME/starship.toml \
  https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/config/starship.toml

[ ! -f $XDG_CONFIG_HOME/micro/settings.json ] && curl -s -o $XDG_CONFIG_HOME/micro/settings.json \
  -s https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/config/micro/settings.json

[ ! -f $XDG_CONFIG_HOME/micro/bindings.json ] && curl -s -o $XDG_CONFIG_HOME/micro/bindings.json \
  https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/config/micro/bindings.json

[ ! -f $XDG_CONFIG_HOME/git/config ] && curl -s -o $XDG_CONFIG_HOME/git/config \
  https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/gitconfig

[ ! -f $XDG_BIN_HOME/git-news ] && curl -s -o $XDG_BIN_HOME/git-news \
  https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/git-news
  chmod +x $XDG_BIN_HOME/git-news

[ ! -f $XDG_BIN_HOME/git-repauthor ] && curl -s -o $XDG_BIN_HOME/git-repauthor \
  https://raw.githubusercontent.com/bbhtt/dotfiles/refs/heads/main/git-repauthor
  chmod +x $XDG_BIN_HOME/git-repauthor

[ ! -d $XDG_CONFIG_HOME/zsh/.antidote ] \
  && git clone -q --depth=1 https://github.com/mattmc3/antidote.git $XDG_CONFIG_HOME/zsh/.antidote

[ ! -f $XDG_CONFIG_HOME/zsh/zsh_plugins.conf ] && touch $XDG_CONFIG_HOME/zsh/zsh_plugins.conf
fpath=($XDG_CONFIG_HOME/zsh/.antidote/functions $fpath)
autoload -Uz antidote
[ -f $XDG_CONFIG_HOME/zsh/zsh_plugins.conf ] \
  && [ ! -f $XDG_CONFIG_HOME/zsh/zsh_plugins.zsh ] \
  && antidote bundle <$XDG_CONFIG_HOME/zsh/zsh_plugins.conf >|$XDG_CONFIG_HOME/zsh/zsh_plugins.zsh

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# preview directory's content with eza when completing ls
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

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

dockersize() {
  docker manifest inspect -v "$1" | \
  jq -c 'if type == "array" then .[] else . end' | \
  jq -r '[
    ( .Descriptor.platform | [ .os, .architecture, .variant, ."os.version" ] | del(..|nulls) | join("/") ),
    ( [ ( .OCIManifest // .SchemaV2Manifest ).layers[].size ] | add )
  ] | join(" ")' | \
  numfmt --to iec --format '%.2f' --field 2 | \
  sort | \
  column -t
}

dockerdigest() {
    docker manifest inspect "$1" | jq -r '.manifests[] | "\(.platform.architecture) \(.digest)"' | 
    sed 's/sha256://g' |
    sort
}

jwt-decode() {
  local token="${1:-$(cat)}"
  jq -R 'split(".") |.[0:2] | map(gsub("-"; "+") | gsub("_"; "/") | gsub("%3D"; "=") | @base64d) | map(fromjson)' <<< "$token"
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
alias pdiff="/usr/bin/diff -Nru"
alias pcat="/usr/bin/cat"
alias nano="micro"
#alias shredf="shred -uvz"
alias top="top -e m -E m -u $(whoami)"
alias pf="printf '%s\n' *"
alias rgtagmp3="mp3gain -s i -r -e *.mp3"
alias cat="bat --style=plain"
#alias rm="trash-rm"
alias yank="yank-cli -- wl-copy"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias irssi="irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi"
alias gpdiff="git difftool --tool=diff"
alias resolve="dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml -resolve"
alias pgit="/bin/git"
alias prm="/bin/rm"

## Environment variables
# Needs to be hardcoded to user
export MICRO_CONFIG_HOME="$HOME/.config/micro"
export MICRO_TRUECOLOR="1"
export EDITOR="micro"
export VISUAL="micro"
export GIT_EDITOR="micro +1"
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
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export PYTHON_HISTORY=$XDG_DATA_HOME/python_history
# docker-compose v2 systemctl --user enable --now podman.socket
#export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

# antidote plugin manager
# needs to stay below if using plugins that needs autoload compdef etc.
source $XDG_CONFIG_HOME/zsh/zsh_plugins.zsh
# zsh-syntax-highlighting
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# cursor should be removed - causes it do disappear on pressing back
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=13'
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
