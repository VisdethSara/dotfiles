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
# file
export HISTFILE=~/.bash_history

# large history
export HISTSIZE=50000
export HISTFILESIZE=100000

# ignore Commands starting with a space, or containing secrets
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE='*password*:*passwd*:*secret*:*token*:*key*'

# append, not overwrite
shopt -s histappend

PROMPT_COMMAND='history -a; history -n; history -c; history -r; '"$PROMPT_COMMAND"

# ---- useful shopt ----
shopt -s autocd        # typing a directory name cd's into it
shopt -s cdspell       # fixes minor typos in cd
shopt -s globstar      # ** recursive globbing
shopt -s extglob

# ---- prompt ----
export PS1='\[\e[95m\]\u\e[32m\]@\[\e[94m\]\h\[\e[32m\] \[\e[91m\]>\W<\[\e[0m\]$\[\e[0m\] '
