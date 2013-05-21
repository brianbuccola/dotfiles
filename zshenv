# colorize less, especially for manpages
export LESS_TERMCAP_mb=$(printf "\e[1;31m")     # begin blinking
export LESS_TERMCAP_md=$(printf "\e[1;31m")     # begin bold
export LESS_TERMCAP_me=$(printf "\e[0m")        # end mode
export LESS_TERMCAP_se=$(printf "\e[0m")        # end standout mode
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")  # begin standout mode (info box)
export LESS_TERMCAP_ue=$(printf "\e[0m")        # end underline
export LESS_TERMCAP_us=$(printf "\e[1;32m")     # begin underline

# java look and feel; needed to make JabRef fonts look OK
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

# environment variables
export PATH="$PATH:$HOME/texlive/2012/bin/x86_64-linux:$HOME/scripts:$HOME/blog"
export MANPATH="$MANPATH:$HOME/texlive/2012/texmf/doc/man"
export INFOPATH="$INFOPATH:$HOME/texlive/2012/texmf/doc/info"
export SUDO_EDITOR="/usr/bin/vim -p"
export VISUAL="/usr/bin/vim -p -X"
export EDITOR="/usr/bin/vim -p"
