#!/bin/sh
#
# Sourced by $HOME/.zshrc

autoload -U colors && colors

#precmd(){ #{{{
#
#vcs_info 'prompt'
#local GIT_BRANCH="$vcs_info_msg_0_"
#
#if [[ -n "$GIT_BRANCH" ]]; then GIT_BRANCH="%{$fg[red]%} $GIT_BRANCH"; fi
#
##PROMPT="${retval}┌┼─┼─┌┤ ${path_p}${GIT_BRANCH} ${retval}${time} ${user}	$(battery)
##${retval}└╼ %{$reset_color%}"
#
#local retval="%(?,%{$fg_bold[green]%},%{$fg_bold[red]%})"
#local retchar="%(?,%b%{$fg[green]%}>>%B>%b,%b%{$fg[red]%}>>%B>%b)"
##local path_p="%~"
##local user_host="%n@%m"
#local time="%{$fg[magenta]%}%*%{$reset_color%}"
#local w=$(echo "${PWD/#$HOME/~}" | sed 's/.*\/\(.*\/.*\/.*\)$/\1/' ) # pwd max depth 3
## pwd max length L, prefix shortened pwd with m
#local L=30 m='←<'
#if [ ${#w} -gt $L ]; then
	#local w="${m}%.";
#fi
#
#PROMPT="%{$fg_bold[blue]%}${w}${GIT_BRANCH} %b$(battery_prompt.pl)%B${retchar} %{$reset_color%}"
#RPROMPT="${time}"
##RPROMPT="${time} $(battery_prompt.pl)"
##RPROMPT="$(battery)"
#
#}
#}}}
#set-prompt

# Gittiness #{{{

# get the name of the branch we are on
function git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo -n "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () { #{{{
	gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')
	if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:$") > 0 ]]; then
		echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
	fi

	if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\)$") > 0 ]]; then
		echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
	fi

	if [[ $(echo ${gitstat} | wc -l | tr -d ' ') == 0 ]]; then
		echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
}
#}}}

# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#function current_branch() {
	#ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	#echo ${ref#refs/heads/}
#}

#}}}

precmd(){

local time="%B%{$fg[black]%}%@%b" #%* for hh:mm:ss
local batt="$(battery_prompt.pl)"

PROMPT="${batt}${time} %b%{$fg[magenta]%}%~%b%{$reset_color%}$(git_prompt_info) "

#PROMPT="%{$fg[yellow]%}%n%{$reset_color%} in %{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)
#$(battery_prompt.pl)%{$fg[green]%}» "
#RPROMPT="${time} %{$reset_color%}"

}
ZSH_THEME_GIT_PROMPT_PREFIX=" [branch: %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
