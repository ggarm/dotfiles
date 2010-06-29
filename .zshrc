# .zshrc
#
# Author: Ricardo Costa 
#
# EXPORTS =================================

# done in .zprofile
#source $HOME/.config/zsh/exports

# ALIASES =================================
# 
#Zsh Auto extension

alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s zip=7z X
alias -s nfo=pnfo

#Idea borrowed from tvale @github 
for ext in png jpg gif; do alias -s $ext=feh; done
for ext in sxw doc ppt; do alias -s $ext=soffice; done
for ext in html org php com net; do alias -s $ext=$BROWSER; done
for ext in java txt c cpp h PKGBUILD; do alias -s $ext=$EDITOR; done
for ext in avi mp3 wav; do alias -s $ext=mplayer; done

#Normal aliases

source $HOME/.config/zsh/aliases

# FUNCTIONS  ==============================
 
source $HOME/.config/zsh/functions

# AUTOCOMPLETE ============================

zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' command 'ps xw -o pid,tty,time,args'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '${RED}*${NC}'
zstyle ':vcs_info:*:prompt:*' stagedstr '${YELLOW}+${NC}'
zstyle ':vcs_info:*:prompt:*' actionformats "${white}[${WHITE}%b%u%c${white}]${NC}" ''
zstyle ':vcs_info:*:prompt:*' formats "${white}[${WHITE}%b%u%c${white}]${NC}" ''
zstyle ':vcs_info:*:prompt:*' nvcsformats '' 


autoload -Uz compinit colors vcs_info
compinit colors
#zle -N zle-line-init
#zle -N zle-keymap-select

# HISTORY =================================
# 
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# OPTIONS =================================
#
setopt appendhistory autocd extendedglob nomatch notify
setopt PROMPT_SUBST
setopt ALWAYS_LAST_PROMPT
WORDCHARS="${WORDCHARS:s#/#}"

# BINDINGS ================================
#
# http://mundy.yazzy.org/unix/zsh.php
# http://www.zsh.org/mla/users/2000/msg00727.html
#
# Emacs bindings (vi are suck-ish)
bindkey -e
#bindkey -v


# 
# typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

#To discover what keycode is being sent, hit ^v
##and then the key you want to test.
bindkey '[7~' beginning-of-line
bindkey '[8~' end-of-line

bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^[[D' backward-char

bindkey 'Oc' forward-word 
bindkey 'Od' backward-word

# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# = PROMPT ======================================

source $HOME/.config/zsh/prompt

# Set urxvt title
case $TERM in
 screen|xterm|rxvt*)
  #cat /etc/motd;
  fortune;
  PROMPT_COMMAND='';
  trap 'echo -ne "\e]0;$BASH_COMMAND\007" ' DEBUG;
 ;;
esac
