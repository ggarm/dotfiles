#!/bin/sh

GREP_COLORS="38;5;230:sl=38;5;240:cs=38;5;100:mt=38;5;161:fn=38;5;197:ln=38;5;212:bn=38;5;44:se=38;5;166"

if [ "$TERM" = "linux" ]; then 
# FB_COLORS {{{
# trapd00r {{{
	#echo -en "\e]P01c1c1c" #black
	#echo -en "\e]P81c1c1c" #darkgrey
	#echo -en "\e]P1ff4747" #darkred
	#echo -en "\e]P9ff6767" #red
	#echo -en "\e]P24d4c4c" #darkgreen
	#echo -en "\e]PAb03b31" #green
	#echo -en "\e]P3ff8f00" #brown
	#echo -en "\e]PBbdf13d" #yellow
	#echo -en "\e]P41165e9" #darkblue
	#echo -en "\e]PC5496ff" #blue
	#echo -en "\e]P589005a" #darkmagenta
	#echo -en "\e]PDb50077" #magenta
	#echo -en "\e]P6cb1c13" #darkcyan
	#echo -en "\e]PE6be603" #cyan
	#echo -en "\e]P7ffffff" #lightgrey
	#echo -en "\e]PFdedede" #white
	#clear #for background artifacting
	
	LS_COLORS="*.pl=01;35:ow=01;34:no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"
# }}}
# other... {{{
	echo -en "\e]P0000000" #black
	echo -en "\e]P8505354" #darkgrey
	echo -en "\e]P1f92672" #darkred
	echo -en "\e]P9ff5995" #red
	echo -en "\e]P282b414" #darkgreen
	echo -en "\e]PAb6e354" #green
	echo -en "\e]P3fd971f" #brown
	echo -en "\e]PBfeed6c" #yellow
	echo -en "\e]P456c2d6" #darkblue
	echo -en "\e]PC8cedff" #blue
	echo -en "\e]P58c54fe" #darkmagenta
	echo -en "\e]PD9e6ffe" #magenta
	echo -en "\e]P6465457" #darkcyan
	echo -en "\e]PE899ca1" #cyan
	echo -en "\e]P7ccccc6" #lightgrey
	echo -en "\e]PFf8f8f2" #white
	#clear # back to default input colours
#}}}
# }}}
else
#LS_COLORS {{{
LS_COLORS="*.git=38;5;197:*.xinitrc=38;5;75:*.Xdefaults=38;5;77:*.Xresources=38;5;77:*.gtkrc-2.0=38;5;77:*.procmailrc=38;5;73:*.rtorrent.rc=38;5;73:*.sbclrc=38;5;73:*.screenrc=38;5;74:*.toprc=38;5;73:*.urlview=38;5;85:*.bashrc=38;5;74:*.zshrc=38;5;74:*.nanorc=38;5;76:*.vimrc=38;5;78:*.vimperatorrc=38;5;78:*.dump=38;5;119:*.msmtprc=38;5;73:*.muttrc=38;5;73:*.conf=38;5;226:*.md=38;5;184:*.markdown=38;5;184:*.h=38;5;81:*.rb=38;5;192:*.cpp=38;5;108:*.c=38;5;110:*.diff=42;38:*.yml=38;5;208:*.PL=38;5;160:*.csv=38;5;78:tw=38;5;003:*.chm=38;5;144:*.bin=38;5;249:*.sms=38;5;33:*.pdf=38;5;203:*.cbz=38;5;140:*.cbr=38;5;140:*.nes=38;5;160:*.mpg=38;5;38:*.ts=38;5;39:*.sfv=38;5;191:*.m3u=38;5;172:*.txt=38;5;192:*.log=38;5;190:*.bash=38;5;173:*.swp=38;5;241:*.swo=38;5;236:*.theme=38;5;109m:*.zsh=38;5;173:*.nfo=38;5;113:mi=38;5;124:or=38;5;160:ex=38;5;197:ln=target:pi=38;5;126:ow=38;5;208:di=38;5;30:*.pm=38;5;197:*.pl=38;5;215:*.sh=38;5;113:*.patch=45;37:*.tar=38;5;118:*.tar.gz=38;5;118:*.zip=38;5;11::*.rar=38;5;11:*.tgz=38;5;11:*.7z=38;5;11:*.mp3=38;5;173:*.flac=38;5;166:*.mkv=38;5;115:*.avi=38;5;114:*.wmv=38;5;113:*.wav=38;5;112:*.jpg=38;5;66:*.jpeg=38;5;67:*.png=38;5;68:*.gif=38;5;69:*.pacnew=38;5;33"

#LS_COLORS="rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.wsz=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"
# }}}
fi
export GREP_COLORS;
export LS_COLORS;
