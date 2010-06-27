. $HOME/.sh/exports
#. $HOME/.zshrc

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then startx 2>/dev/null &; fi
