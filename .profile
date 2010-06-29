. $HOME/.config/zsh/exports

case $SHELL in 
    bash) . ~/.bashrc; ;;
    zsh) . ~/.zshrc; ;;
esac

#if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then xinit fi
