# .zshrc
#
# Author: Ricardo Costa 
#
# Last Modified: 2011-10-08 16:14
#
# done in .zprofile
source $HOME/.config/zsh/exports.zsh

#for i in {colors,aliases,functions,opts,style,binds,prompt}; do
	#source $HOME/.config/zsh/$i.zsh
#done;

# source /home/ricardo/.config/zsh/auto-fu.zsh

source $HOME/.config/zsh/colors.zsh
source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/opts.zsh
source $HOME/.config/zsh/style.zsh
source $HOME/.config/zsh/binds.zsh
source $HOME/.config/zsh/zsh-history-substring-search.plugin.zsh
source $HOME/.config/zsh/git-flow.zsh
source $HOME/.config/zsh/prompt.zsh

# source /home/ricardo/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#fpath FIXME Move all plugins?
fpath=(~/.zsh/functions/ $fpath)

# Set terminal title
case $TERM in
	linux)
		echo -n "$fg_bold[white]Arch$fg_bold[blue]linux$fg[white]";
		#cat /etc/motd
		;;
	xterm*|rxvt*)
		[ -f ~/TODO ] && v ~/TODO
		#PROMPT_COMMAND='';
		#trap 'echo -ne "\e]0;$BASH_COMMAND\007" ' DEBUG;
		;;
	screen*)
		echo -n "$fg_bold[white]Arch$fg_bold[blue]linux$fg[white]\v\t";
		[ -f ~/Scripts/slogans/slogan.txt ] && shuf -n1 ~/Scripts/slogans/slogan.txt
		#echo -n "$reset_color";
		;;
esac

#vim: set st=2 sts=2
