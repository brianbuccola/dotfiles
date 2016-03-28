# Zsh options
setopt correct
setopt noclobber
setopt autocd
setopt no_case_glob
setopt extended_glob
setopt no_match
setopt notify
setopt append_history
setopt dvorak
setopt promptsubst
setopt no_beep
setopt inc_append_history
setopt share_history

# Vi keybindings
bindkey -v

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Git prompt
local gitval='$(__git_ps1 " (%s)")'
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

# History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey '^R' history-incremental-search-backward

# Completion styling
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix
zstyle ':completion:*' format $'%{\e[0;31m%}Completing %B%d%b%{\e[0m%}'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select
zstyle ':completion:*' prompt '%e errors found'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/brian/.zshrc'

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu select

autoload -Uz compinit
compinit

## Make <S-Tab> do reverse completion.
bindkey '^[[Z' reverse-menu-complete

# Colors
autoload -U colors
colors
GRUVBOX_SHELL="${HOME}/.vim/bundle/gruvbox/gruvbox_256palette.sh"
[[ -s ${GRUVBOX_SHELL} ]] && source "${GRUVBOX_SHELL}"

# Custom prompt
PROMPT="%B%T%b [%{$fg_bold[red]%}%?%{$reset_color%}]%{$fg_no_bold[green]%}${gitval}%{$reset_color%} %# "
RPROMPT="%{$fg_no_bold[green]%}%~%{$reset_color%}"

# Aliases
alias ...='cd ../..'
alias ....='cd ../../..'
alias ghci='ghci-color'
alias j='jobs -l'
alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='ls -alh'
alias ld='ls -d .*/ */'
alias l.='ls -d .*'
alias grep='grep --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias x='startx'
alias bd='bashdown'
alias bp='echo -e "\a"'
alias db='dropbox-cli start && watch -n1 dropbox-cli status && dropbox-cli stop'
alias ipa='feh -F ~/downloads/IPA_chart_2005.png &'
alias pg='ping www.google.com'
alias vpn-mcgill='sudo openconnect securevpn.mcgill.ca'
alias vpn-mit='sudo openconnect vpn.mit.edu'
alias g='git'
alias mx='mpv $(xsel)'

# Functions
lspdf() {
    if [[ $? -eq 0 ]]; then
        ls | column -t -s '_' | sed 's/\.pdf$//g' | sed 's/-/ /g'
    elif [[ $? -eq 1 ]]; then
        ls "$1" | column -t -s '_' | sed 's/\.pdf$//g' | sed 's/-/ /g'
    else
        echo "Error: too many arguments."
    fi
}

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
export PATH="$PATH:$HOME/texlive/2015/bin/x86_64-linux:$HOME/repos/scripts:$HOME/.cabal/bin:$HOME/.gem/ruby/2.3.0/bin"
export MANPATH="$MANPATH:$HOME/texlive/2015/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:$HOME/texlive/2015/texmf-dist/doc/info"
export SUDO_EDITOR="/usr/bin/vim -p"
export VISUAL="/usr/bin/vim -p -X"
export EDITOR="/usr/bin/vim -p"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
