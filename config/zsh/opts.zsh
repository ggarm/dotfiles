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
setopt interactive_comments
#setopt noclobber					# no accidental overwrite
setopt correct						# did you mean [nyae]?
setopt correctall					# ^^ for all args
#setopt CSHJUNKIEQUOTES    # quote unmatched :) 
unsetopt BG_NICE 
unsetopt bgnice				# do NOT nice bg commands

autoload -Uz compinit colors vcs_info
compinit colors

# smart urls
autoload -U url-quote-magic
#zle -N self-insert url-quote-magic



HISTFILE=$HOME/.histfile
HISTSIZE=5000
SAVEHIST=5000
WORDCHARS="${WORDCHARS:s#/#}"
REPORTTIME=5       # report about cpu-/system-/user-time of command if running longer than 5 seconds
