# Check for an interactive session
[ -z "$PS1" ] && return

. $HOME/.config/zsh/aliases.zsh
. $HOME/.config/zsh/functions.zsh
#. $HOME/.config/zsh/exports.zsh

# cd to a dir without cd!
shopt -s autocd
# spell check cd commands
shopt -s cdspell
# spell correction for tab completion
shopt -s dirspell
# include hidden files in pattern match
shopt -s dotglob
# matches filenames in a case-insensitive fashion when performing filename expansion.
shopt -s nocaseglob
# will not attempt to search the PATH for possible completions when completion is attempted on an empty line. 
shopt -s no_empty_cmd_completion
# do not overwrite the hist file, append to it.
shopt -s histappend 

#Original prompt
#PS1='[\u@\h \W]\$ '
#Colorized prompt
#PS1='[\[\e[0;36m\]\u@\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[m\]\[\e[0;37m\]]\[\e[1;36m\]\$ \[\e[m\]\[\e[39m\]'
# Auguste prompt :P
#PS1="[ \A - \u @ \w ]\n> "

#Nifty prompt
white='\[\e[0;1m\]'        # 0 = reset all attributes, which usually means gray text on black background, 1 = bold
cyan='\[\e[36;1m\]'        # 36 = cyan foreground, 1 = bold
_cyan='\[\e[0;36m\]'        # 36 = cyan foreground, 0 = normal
blue='\[\e[34;1m\]'        # 34 = blue, 1 = bold
green='\[\e[32;1m\]' 	   # 32 = green, 1 = bold
red='\[\e[31;1m\]'         # 31 = red, 1 = bold
_red='\[\e[0;31m\]' 	   # 31 = red, 0 = normal
normal='\[\e[0m\]'         # 0 = reset all attributes
#PS1="$white┌─( $red\A$white ) - ( $cyan\u$white ) - ( $blue\w$white )\n└─> $normal"  # You
#PS1="$white┌─( $red\u$white ) - ( $cyan\w$white )\n└─> $normal"  # Root

PS1="$white( $red\A$white ) - ( $cyan\u$white @ $blue\w$white ) $cyan>> $normal"  # You

# Set urxvt title
case $TERM in
 screen|xterm|rxvt*)
  cat /etc/motd;
  fortune -n256;
  #PROMPT_COMMAND='echo -ne "\e]0;$USER@$HOSTNAME: $BASH_COMMAND\007" '
  PROMPT_COMMAND='';
  trap 'echo -ne "\e]0;$BASH_COMMAND\007" ' DEBUG;
  #trap 'echo -ne "\e]0;$USER@$HOSTNAME: $BASH_COMMAND\007" ' DEBUG;
 ;;
esac

