# vim:      set ft=sh:
# file:     ~/.bashrc
# author:   Brian Buccola

# prompt
CURRENTUSER=`whoami`
if [[ "$CURRENTUSER" = "root" ]]; then
    PS1='\[\e[91m\]\u: \w #\[\e[0m\] '
else
    PS1='\w \$ '
fi

# vi mode
set -o vi

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
alias mtab="cat /etc/mtab | column -t"
alias bp='echo -e "\a"'
alias lp2="lp -o number-up=2"
alias ccp="rsync -Ph"
alias x="startx"
alias lspapers="ls $HOME/documents/papers/ | sed 's/.pdf//' | column -t -s '-' | less"
alias lsbooks="ls $HOME/documents/books/ | sed 's/.pdf//' | sed 's/.djvu//' | column -t -s '-' | less"
alias tex-rm="rm *.aux *.bbl *.blg *.log *.out"
alias yu="yaourt -Syyu"
alias yua="yaourt -Syyua"
alias ghci="ghci-color"

# environment variables
export PATH="$PATH:$HOME/scripts:$HOME/texlive/2011/bin/x86_64-linux:$HOME/.cabal/bin:$HOME/.gem/ruby/1.9.1/bin"
export MANPATH="$MANPATH:$HOME/texlive/2011/texmf/doc/man"
export INFOPATH="$INFOPATH:$HOME/texlive/2011/texmf/doc/info"
export SUDO_EDITOR="/usr/bin/vim -p"
export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"

# make man pages narrower
export MANWIDTH=80

# use vim instead of less to view manpages
# http://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
#export MANPAGER="sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# add auto-completion for sudo and man
complete -cf sudo
complete -cf man

# java look and feel; needed to make JabRef fonts look OK
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
