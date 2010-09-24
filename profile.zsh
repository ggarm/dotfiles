. $HOME/.config/zsh/exports.zsh
. $HOME/.config/zsh/opts.zsh

WORDCHARS="${WORDCHARS:s#/#}"
REPORTTIME=5       # report about cpu-/system-/user-time of command if running longer than 5 seconds
#unsetopt BG_NICE 
#unsetopt bgnice				# do NOT nice bg commands

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then xinit 2>/dev/null &; fi
