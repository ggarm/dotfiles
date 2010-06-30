. $HOME/.config/zsh/exports.zsh

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then xinit 2>/dev/null &; fi
