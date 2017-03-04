# Zsh options
setopt append_history
setopt autocd
setopt correct
setopt dvorak
setopt extended_glob
setopt inc_append_history
setopt no_beep
setopt no_case_glob
setopt no_match
setopt no_clobber
setopt notify
setopt promptsubst
setopt share_history

# Vi keybindings
bindkey -v

# Edit command in text editor
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd "^E" edit-command-line
bindkey -M viins "^E" edit-command-line

# Don't eat space after '<Tab>' followed by '&' or '|'
ZLE_SPACE_SUFFIX_CHARS=$'&|'

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Git prompt
local gitval='$(__git_ps1 " (%s)")'
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

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

## Make <S-Tab> do reverse completion
bindkey '^[[Z' reverse-menu-complete

# Colors
autoload -U colors
colors
GRUVBOX_SHELL="${HOME}/.vim/plugged/gruvbox/gruvbox_256palette.sh"
[[ -s ${GRUVBOX_SHELL} ]] && source "${GRUVBOX_SHELL}"

# Custom prompt
PROMPT="%B%T%b [%{$fg_bold[red]%}%?%{$reset_color%}]%{$fg_no_bold[green]%}${gitval}%{$reset_color%} %# "
RPROMPT="%{$fg_no_bold[green]%}%~%{$reset_color%}"

# Aliases
alias ...='cd ../..'
alias ....='cd ../../..'
alias bp='echo -e "\a"'
alias cp='cp -i'
alias db='dropbox-cli start && watch -n1 dropbox-cli status && dropbox-cli stop'
alias ghci='ghci-color'
alias grep='grep --color=auto'
alias j='jobs -l'
alias js='bundle exec jekyll serve'
alias la='ls -a'
alias ld='ls -d .*/ */'
alias ll='ls -alh'
alias l.='ls -d .*'
alias ls='ls --color=auto -F'
alias mv='mv -i'
alias mx='mpv $(xsel)'
alias p='pacaur'
alias pg='ping www.google.com'
alias vless="vim -u /usr/share/vim/vim74/macros/less.vim"
alias vpn-mcgill='sudo openconnect securevpn.mcgill.ca'
alias vpn-mit='sudo openconnect vpn.mit.edu'
alias x='startx'
alias xmr='pkill xmobar && xmonad --restart'

# Functions
g() {
    if [[ $(pwd) = ${HOME} ]]; then
        /usr/bin/git --git-dir=${HOME}/repos/dotfiles --work-tree=${HOME} $@
    else
        /usr/bin/git $@
    fi
}

lspdf() {
    if [[ $? -eq 0 ]]; then
        ls | \
          sed 's/\.pdf$//g' | \
          sed 's/\./, /g' | \
          sed 's/-/ /g' | \
          column -t -s '_'
    elif [[ $? -eq 1 ]]; then
        ls "$1" | column -t -s '_' | sed 's/\.pdf$//g' | sed 's/-/ /g'
    else
        echo "Error: too many arguments."
    fi
}

# Add completions to aliases and functions
compdef g=git
compdef p=pacaur

# colorize less, especially for manpages
export LESS_TERMCAP_mb=$(printf "\e[1;31m")     # begin blinking
export LESS_TERMCAP_md=$(printf "\e[1;31m")     # begin bold
export LESS_TERMCAP_me=$(printf "\e[0m")        # end mode
export LESS_TERMCAP_se=$(printf "\e[0m")        # end standout mode
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")  # begin standout mode (info box)
export LESS_TERMCAP_ue=$(printf "\e[0m")        # end underline
export LESS_TERMCAP_us=$(printf "\e[1;32m")     # begin underline

# environment variables
export PATH="$PATH:$HOME/texlive/2016/bin/x86_64-linux:$HOME/repos/scripts:$HOME/.gem/ruby/2.4.0/bin:$HOME/.cabal/bin"
export MANPATH="$MANPATH:$HOME/texlive/2016/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:$HOME/texlive/2016/texmf-dist/doc/info"
export SUDO_EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export PASSWORD_STORE_X_SELECTION="primary"
export GPG_TTY=$(tty)
