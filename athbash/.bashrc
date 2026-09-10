# ~/.bashrc
set +H # Malware analysis using literal !, stop treating as history expansion
# Append "$1" to $PATH when not already in.
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
append_path "$HOME/bin"
append_path "$HOME/.local/bin"

### EXPORT ### Should be before the change of the shell
export EDITOR=/usr/bin/nvim
export VISUAL='nano'
export HISTCONTROL=ignoreboth:erasedups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s histappend
export PAGER='most'

export TERM=xterm-256color
export SHELL=$(which bash)

export SECLISTS="/usr/share/seclists"
export PAYLOADSALLTHETHINGS="/usr/share/payloadsallthethings"
export FUZZDB="/usr/share/fuzzdb"

export MIMIKATZ="/usr/share/windows/mimikatz/"
export POWERSPLOIT="/usr/share/windows/powersploit/"

export ROCKYOU="$SECLISTS/Passwords/Leaked-Databases/rockyou.txt"
export DIRSMALL="$SECLISTS/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-small.txt"
export DIRMEDIUM="$SECLISTS/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt"
export DIRBIG="$SECLISTS/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-big.txt"
export WEBAPI_COMMON="$SECLISTS/Discovery/Web-Content/api/api-endpoints.txt"
export WEBAPI_MAZEN="$SECLISTS/Discovery/Web-Content/common-api-endpoints-mazen160.txt"
export WEBCOMMON="$SECLISTS/Discovery/Web-Content/common.txt"
export WEBPARAM="$SECLISTS/Discovery/Web-Content/burp-parameter-names.txt"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- One-time setup ---
if [[ $1 != no-repeat-flag && -z $NO_REPETITION ]]; then
  export NO_REPETITION=1
  fastfetch
fi

# Optional: Source Blesh if installed
[[ $1 != no-repeat-flag && -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh

# --- Bash completion ---
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# --- Aliases ---
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# --- Shell behavior ---
shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s histappend
shopt -s expand_aliases

# --- ex (extractor helper) ---
ex () {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   tar xf "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# --- Git helpers ---
vimod () {
  vim -p $(git status -suall | awk '{print $2}')
}

virev () {
  local commit=${1:-HEAD}
  local rootdir=$(git rev-parse --show-toplevel)
  local sourceFiles=$(git show --name-only --pretty="format:" "$commit" | grep -v '^$')
  local toOpen=""
  for file in $sourceFiles; do
    local fullpath="$rootdir/$file"
    [ -e "$fullpath" ] && toOpen="$toOpen $fullpath"
  done
  if [ -z "$toOpen" ]; then
    echo "No files were modified in $commit"
    return 1
  fi
  vim -p $toOpen
}

gitPrompt() {
  command -v __git_ps1 > /dev/null && __git_ps1 " (%s)"
}

# --- cd up helper ---
cu () {
  local count=$1
  [[ -z "$count" ]] && count=1
  local upath=""
  for i in $(seq 1 $count); do
    upath+="../"
  done
  cd "$upath"
}

# --- Memory cleaning helper ---
buffer_clean(){
  free -h && sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches' && free -h
}

# --- Fish-style dynamic set_bash_prompt() {
set_bash_prompt() {
    local last_status=$?
    local ip
    local branch=""

    ip=$(
        ip -4 addr show scope global |
        awk '/inet / {
            split($2, a, "/")
            ips = ips (ips ? "|" : "") a[1]
        }
        END { print ips }
        '
    )

    if command -v git &>/dev/null; then
        branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)
    fi

    if (( last_status == 0 )); then
        local status_color='\[\e[1;34m\]'
    else
        local status_color='\[\e[1;31m\]'
    fi

    PS1='\[\e[1;32m\]+-[HQ\[\e[1;31m\]-'"$ip"'\[\e[1;32m\]]-'
    PS1+="${status_color}"
    PS1+='(\u@\h)\[\e[0m\]'

    if [[ -n "$branch" ]]; then
        PS1+='\[\e[1;33m\][git:'"$branch"']\[\e[0m\]'
    fi

    PS1+=$'\n'
    PS1+='\[\e[1;32m\]+->\[\e[1;36m\]\w \$\[\e[0m\] '
}

PROMPT_COMMAND=set_bash_prompt
