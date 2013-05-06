# vim:      set ft=sh:
# file:     ~/.bashrc
# author:   Brian Buccola

# prompt
if [[ "$(whoami)" = "root" ]]; then
    PS1='\[\e[91m\](\u) \w #\[\e[0m\] '
else
    PS1='\[\e[37m\]\w \$\[\e[0m\] '
fi

# vi mode
set -o vi

# git completion
source /usr/share/git/completion/git-completion.bash

# aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .-="cd -"
alias ls="ls --color=auto"
alias ll="ls -alh"
alias la="ls -a"
alias l.="ls -d .*"
alias mv="mv -i"
alias cp="cp -i"
alias c="clear"
alias grep="grep --color=auto"
alias vless="vim -u /usr/share/vim/vim73/macros/less.vim"
alias pacman="sudo pacman"
alias mount="sudo mount"
alias umount="sudo umount"
alias vpnc="sudo vpnc /etc/vpnc/mcgill.conf"
alias vpnc-disconnect="sudo vpnc-disconnect"
alias bp='echo -e "\a"'
alias lp2="lp -o number-up=2"
alias lp-mcgill="lp -d HP_LaserJet_2300_series"
alias ccp="rsync -Ph"
alias x="startx"
alias lspapers="ls $HOME/documents/papers/ | sed 's/.pdf//' | column -t -s '-' | less"
alias lsbooks="ls $HOME/documents/books/ | sed 's/.pdf//' | sed 's/.djvu//' | column -t -s '-' | less"
alias yu="yaourt -Syyu"
alias yua="yaourt -Syyua"
alias ghci="ghci-color"

# environment variables
export PATH="$PATH:$HOME/scripts:$HOME/texlive/2011/bin/x86_64-linux:$HOME/.cabal/bin:$HOME/blog"
export MANPATH="$MANPATH:$HOME/texlive/2011/texmf/doc/man"
export INFOPATH="$INFOPATH:$HOME/texlive/2011/texmf/doc/info"
export SUDO_EDITOR="/usr/bin/vim -p"
export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"

# make man pages narrower
export MANWIDTH=80

# add auto-completion for sudo and man
complete -cf sudo
complete -cf man

# java look and feel; needed to make JabRef fonts look OK
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
