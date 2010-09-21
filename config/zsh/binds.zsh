#!/bin/sh

# http://mundy.yazzy.org/unix/zsh.php
# http://www.zsh.org/mla/users/2000/msg00727.html
#
# Emacs bindings (vi are suck-ish)
bindkey -e
#bindkey -v

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
