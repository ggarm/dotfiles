#!/bin/sh
#
# Source by $HOME/.zshrc

autoload -U colors && colors

battery_percent() { #{{{
# I want to know my battery percentage when running on battery power
if which acpi 2>/dev/null; then
	local BATTSTATE="$(acpi -b)"
	local BATTPRCNT="$(echo ${BATTSTATE[(w)4]}|sed -r 's/(^[0-9]+).*/\1/')"
	if [[ -z "${BATTPRCNT}" ]]; then
		PR_BATTERY=""
	elif [[ "${BATTPRCNT}" -lt 15 ]]; then
		PR_BATTERY="${PR_BOLD_RED} batt:${BATTPRCNT}%%"
	elif [[ "${BATTPRCNT}" -lt 50 ]]; then
		PR_BATTERY="${PR_BOLD_YELLOW} batt:${BATTPRCNT}%%"
	elif [[ "${BATTPRCNT}" -lt 96 ]]; then
		PR_BATTERY=" batt:${BATTPRCNT}%%"
	else
		PR_BATTERY=""
	fi
fi
} #}}}

#function zle-line-init zle-keymap-select { # {{{
	#VIMODE="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
	#RPS1="%{$fg_bold[blue]%}${VIMODE}%{$reset_color%}"
	#zle reset-prompt
#} # }}}

precmd(){ #{{{

vcs_info 'prompt'
local GIT_BRANCH="$vcs_info_msg_0_"

if [[ -n $GIT_BRANCH ]]; then GIT_BRANCH="%{$fg[red]%} $GIT_BRANCH"; fi

#PROMPT=$'%{${fg[yellow]}%}%B® %n%b%{${fg[default]}%} %{${fg[blue]}%}%B%~%b%{${fg[default]}%}
#%{${fg[yellow]}%}%B®®%b ${exit} ${fg[default]}→ '

#PROMPT="%{${fg[yellow]}%} ${exit} %{${fg[yellow]}%}%n%{${fg[default]}%} %{${fg[blue]}%}%B%~%b ${char} %{${fg[default]}%}"

# Messing up with the prompt
local retval="%(?,%{$fg[green]%},%{$fg[red]%})"
local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local blue_cp="%{$fg[blue]%}]%{$reset_color%}"
#local path_p="${blue_op}%{${fg_bold[yellow]}%}%~%b${blue_cp}"
local path_p="%{${fg_bold[blue]}%}%~%b%{$reset_color%}"
#local user_host="${blue_op}%{${fg[yellow]}%}%n@%{${fg[magenta]}%}%m${blue_cp}"
local user="%{${fg[yellow]}%}%n%{$reset_color%}"
#local user="${blue_op}%{${fg[yellow]}%}%n${blue_cp}"
#local time="${blue_op}%{${fg[blue]}%}%T${blue_cp}"
#local time="%{${fg[blue]}%}%T%{$reset_color%}"
local time="%*"
local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
local thunder="%{${fg[green]}%}"`echo -n "\u26A1"` # a lightning bolt
local cur_cmd="${blue_op}%_${blue_cp}"
PROMPT="${retval}┌┤ ${path_p}${GIT_BRANCH} ${retval}${time} ${user}
${retval}└╼ %{$reset_color%}"
RPROMPT=$(battery)
#${retval}└╼ >>%B>%b%{$reset_color%} "
#└──${blue_op}${smiley}${blue_cp} >> "
#PROMPT2="${cur_cmd}> "
#RPROMPT="${thunder} ${bat_percent} $RPROMPT"

} #}}}

#set-prompt
