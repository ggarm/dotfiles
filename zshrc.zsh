# .zshrc
#
# Author: Ricardo Costa 
#
# done in .zprofile {{{
# EXPORTS =================================
#source $HOME/.config/zsh/exports.zsh
#
# ZSTYLE ==================================
#source $HOME/.config/zsh/style.zsh
#
# OPTIONS =================================
#
#source $HOME/.config/zsh/opts.zsh
#
#WORDCHARS="${WORDCHARS:s#/#}"
#REPORTTIME=5       # report about cpu-/system-/user-time of command if running longer than 5 seconds
#}}}

# COLORS ==================================
 
source $HOME/.config/zsh/colors.zsh

# ALIASES =================================

source $HOME/.config/zsh/aliases.zsh

# FUNCTIONS  ==============================
 
source $HOME/.config/zsh/functions.zsh

# BINDINGS ================================

source $HOME/.config/zsh/binds.zsh

# PROMPT ==================================

source $HOME/.config/zsh/prompt.zsh

# Set terminal title
case $TERM in
 xterm*|rxvt*)
	 [ -f ~/TODO ] && cat ~/TODO
  #cat /etc/motd
  #fortune;
  #PROMPT_COMMAND='';
  #trap 'echo -ne "\e]0;$BASH_COMMAND\007" ' DEBUG;
 ;;
esac
