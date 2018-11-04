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
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bp='echo -e "\a"'
alias cp='cp -i'
alias db='dropbox-cli start && watch -n1 dropbox-cli status && dropbox-cli stop'
alias g='git'
alias ghci='ghci-color'
alias grep='grep --color=auto'
alias j='jobs -l'
alias la='ls -a'
alias ld='ls -d .*/ */'
alias ll='ls -alh'
alias l.='ls -d .*'
alias ls='ls --color=auto -F'
alias mv='mv -i'
alias mx='mpv $(xsel)'
alias pg='ping www.google.com'
alias vless="vim -u /usr/share/vim/vim74/macros/less.vim"
alias vpn-mcgill='sudo openconnect securevpn.mcgill.ca'
alias vpn-mit='sudo openconnect vpn.mit.edu'
alias x='startx'

# environment variables
export SUDO_EDITOR="/usr/bin/vim -p"
export VISUAL="/usr/bin/vim -p -X"
export EDITOR="/usr/bin/vim"

# add auto-completion for sudo and man
complete -cf sudo
complete -cf man

# java look and feel; needed to make JabRef fonts look OK
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

# colorize less, especially for manpages
export LESS_TERMCAP_mb=$(printf "\e[1;31m")     # begin blinking
export LESS_TERMCAP_md=$(printf "\e[1;31m")     # begin bold
export LESS_TERMCAP_me=$(printf "\e[0m")        # end mode
export LESS_TERMCAP_se=$(printf "\e[0m")        # end standout mode
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")  # begin standout mode (info box)
export LESS_TERMCAP_ue=$(printf "\e[0m")        # end underline
export LESS_TERMCAP_us=$(printf "\e[1;32m")     # begin underline
