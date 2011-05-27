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
# setopt printexitvalue          # alert me if something's failed
setopt listtypes               # show types in completion
setopt listpacked              # compact completion lists
setopt interactive_comments
#setopt noclobber					# no accidental overwrite
setopt correct						# did you mean [nyae]?
setopt correctall					# ^^ for all args
#setopt CSHJUNKIEQUOTES    # quote unmatched :) 
unsetopt BG_NICE 
unsetopt bgnice				# do NOT nice bg commands
setopt multibyte      # must check?
setopt mark_dirs      # append a '/' to dirs
# setopt glob_dots      # do not require a '.' for files


autoload -Uz compinit colors vcs_info
compinit colors

# Allow kill word and moving forward/backword by word to behave like bash (e.g. stop at / chars)
autoload -U select-word-style
select-word-style bash

# smart urls
autoload -U url-quote-magic
#zle -N self-insert url-quote-magic
# zle -N history-beginning-search-backward



HISTFILE=$HOME/.histfile
HISTSIZE=5000
SAVEHIST=5000
WORDCHARS="${WORDCHARS:s#/#}"
REPORTTIME=5       # report about cpu-/system-/user-time of command if running longer than 5 seconds
