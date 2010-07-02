#!/bin/sh

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
zstyle ':completion:*:scp:*' tag-order
zstyle ':completion:*:scp:*' group-order
zstyle ':completion:*:ssh:*' tag-order
zstyle ':completion:*:ssh:*' group-order

zstyle ':completion:*:correct:*' insert-unambiguous true # start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:history-words' menu yes # activate menu
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select # complete 'cd -<tab>' with menu

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '${RED}*${NC}'
zstyle ':vcs_info:*:prompt:*' stagedstr '${YELLOW}+${NC}'
zstyle ':vcs_info:*:prompt:*' actionformats "${white}[${WHITE}%b%u%c${white}]${NC}" ''
zstyle ':vcs_info:*:prompt:*' formats "${white}[${WHITE}%b%u%c${white}]${NC}" ''
zstyle ':vcs_info:*:prompt:*' nvcsformats '' 
