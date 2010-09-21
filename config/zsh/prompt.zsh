#!/bin/sh
#
# Source by $HOME/.zshrc

autoload -U colors && colors

precmd(){ #{{{

vcs_info 'prompt'
local GIT_BRANCH="$vcs_info_msg_0_"

if [[ -n "$GIT_BRANCH" ]]; then GIT_BRANCH="%{$fg[red]%} $GIT_BRANCH"; fi

#PROMPT="${retval}┌┼─┼─┌┤ ${path_p}${GIT_BRANCH} ${retval}${time} ${user}	$(battery)
#${retval}└╼ ¥%{$reset_color%}"

local retval="%(?,%{$fg_bold[green]%},%{$fg_bold[red]%})"
local retchar="%(?,%b%{$fg[green]%}>>%B>%b,%b%{$fg[red]%}>>%B>%b)"
#local path_p="%~"
#local user_host="%n@%m"
local time="%{$fg[magenta]%}%*%{$reset_color%}"
local w=$(echo "${PWD/#$HOME/~}" | sed 's/.*\/\(.*\/.*\/.*\)$/\1/' ) # pwd max depth 3
# pwd max length L, prefix shortened pwd with m
local L=30 m='←<'
if [ ${#w} -gt $L ]; then
	local w="${m}%.";
fi

PROMPT="%{$fg_bold[blue]%}${w}${GIT_BRANCH} %b$(battery_prompt.pl)%B${retchar} %{$reset_color%}"
RPROMPT="${time}"
#RPROMPT="${time} $(battery_prompt.pl)"
#RPROMPT="$(battery)"

} #}}}

#set-prompt
