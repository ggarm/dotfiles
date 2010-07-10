#!/bin/sh

setopt noflowcontrol			# don’t freeze the terminal if I type Ctrl−S
setopt appendhistory 
setopt autocd
setopt extendedglob
setopt nomatch
setopt notify
setopt prompt_subst
setopt always_last_prompt
setopt nohup
setopt interactivecomments

autoload -Uz compinit colors vcs_info
compinit colors
#zle -N zle-line-init
#zle -N zle-keymap-select

HISTFILE=$HOME/.histfile
HISTSIZE=5000
SAVEHIST=5000
