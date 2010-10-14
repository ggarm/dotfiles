#!/bin/sh

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
 
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-/dev/shm}/zsh 
#zstyle ':completion:*' cache-path $HOME/.cache/zsh
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu yes select=long
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A --sort=-pid -o pid,state,tty,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm apache bin daemon games gdm halt ident junkbust lp mpd mail mailnull \
	named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
	rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd \
	avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail \
	firebird gnats haldaemon hplip irc klog list man cupsys postfix \
	proxy syslog www-data mldonkey sys snort
 
#SSH Completion
zstyle ':completion:*:scp:*' tag-order \
	   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
	   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
	   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
	   hosts-domain hosts-host users hosts-ipaddr

zstyle ':completion:*:correct:*' insert-unambiguous true # start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:history-words' menu yes # activate menu
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select # complete 'cd -<tab>' with menu
zstyle ':completion:*:functions' ignored-patterns '_*'

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
	'*?.old' '*?.pro'

zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '${RED}*${NC}'
zstyle ':vcs_info:*:prompt:*' stagedstr '${YELLOW}+${NC}'
zstyle ':vcs_info:*:prompt:*' actionformats "${white}[${WHITE}%b%u%c${white}]${NC}" ''
zstyle ':vcs_info:*:prompt:*' formats "${white}[${WHITE}%b%u%c${white}]${NC}" ''
zstyle ':vcs_info:*:prompt:*' nvcsformats '' 

