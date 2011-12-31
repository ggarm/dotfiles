#!/bin/sh
#
# Sourced by $HOME/.zshrc

autoload -U colors && colors

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

	local time="%B%{$fg[white]%}%@%b" #%* for hh:mm:ss

	PROMPT="${time} %B%{$fg[red]%}%~%B%{$reset_color%}$(git_prompt_info) "

	#PROMPT="%{$fg[yellow]%}%n%{$reset_color%} in %{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)
	#$(battery_prompt.pl)%{$fg[green]%}» "
	#RPROMPT="${time} %{$reset_color%}"

}
# ZSH_THEME_GIT_PROMPT_PREFIX=" [branch: %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%B%{$fg[white]%} on %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
