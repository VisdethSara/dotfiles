#
# ~/.bashrc
#

# ---- only run in interactive shells ----
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"

# ---- load ble.sh ----
[[ -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh

# ---- aliases ----
alias c='clear'
alias rdp='xfreerdp3'
alias xfreerdp='xfreerdp3'
alias wbarrel='pkill waybar; hyprctl dispatch exec waybar'
alias please='sudo $(fc -ln -1)'

# pacman helpers
alias ins='yay -Syy --answerclean None --answerdiff None --mflags "--noconfirm"'
alias update='yay -Syu'

# safety
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# colour
alias ls='ls --color=auto'
alias grep='grep --color=auto'


# ---- history settings ----
export HISTFILE=~/.bash_history
export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups

shopt -s histappend

PROMPT_COMMAND='history -a; history -n; '"$PROMPT_COMMAND"

# ---- useful shopt ----
shopt -s autocd        # typing a directory name cd's into it
shopt -s cdspell       # fixes minor typos in cd
shopt -s globstar      # ** recursive globbing
shopt -s extglob

# ----- colored man pages -----
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# ---- prompt ----
export PS1='\[\e[95m\]\u\e[32m\]@\[\e[94m\]\h\[\e[32m\] \[\e[91m\]>\W<\[\e[0m\]$\[\e[0m\] '
