# .zshrc
#
# Author: Ricardo Costa 
#
# EXPORTS =================================
# done in .zprofile
#source $HOME/.config/zsh/exports.zsh

# COLORS ==================================
# 
source $HOME/.config/zsh/colors.zsh

# ALIASES =================================

source $HOME/.config/zsh/aliases.zsh

# FUNCTIONS  ==============================
 
source $HOME/.config/zsh/functions.zsh

# ZSTYLE ==================================

source $HOME/.config/zsh/style.zsh

# OPTIONS =================================

source $HOME/.config/zsh/opts.zsh

WORDCHARS="${WORDCHARS:s#/#}"

# BINDINGS ================================

source $HOME/.config/zsh/binds.zsh

# PROMPT ==================================

source $HOME/.config/zsh/prompt.zsh

# Set terminal title
case $TERM in
 screen*|xterm|rxvt*)
  cat /etc/motd
  #fortune;
  #PROMPT_COMMAND='';
  #trap 'echo -ne "\e]0;$BASH_COMMAND\007" ' DEBUG;
 ;;
esac
