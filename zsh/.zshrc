# vim:    ft=zsh tw=0
# file:   ~/.zshrc
# author: Brian Buccola <brian.buccola@gmail.com>

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

# Surround functionality
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# Edit command in text editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^E" edit-command-line
bindkey -M viins "^E" edit-command-line

# Use "jj" to enter vi-cmd-mode
bindkey -M viins "jj" vi-cmd-mode

# Traverse history with '^P' and '^N'.
bindkey -M viins '^P' up-history
bindkey -M viins '^N' down-history

# Don't eat space after '<Tab>' followed by '&' or '|'
ZLE_SPACE_SUFFIX_CHARS=$'&|'

# Eat space after '<Tab>' followed by ')', etc.
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;)'

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf (fuzzy finder) keybindings and completion
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

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
autoload -Uz colors
colors

# Custom prompt
PROMPT="┌─%B%T%b %(?..[%B%F{red}%?%f%b] )%F{white}%~%f
└─╼%F{white}${gitval}%f %# "

# Aliases
alias ...='cd ../..'
alias ....='cd ../../..'
alias bp='echo -e "\a"'
alias cp='cp -i'
alias db='dropbox-cli start && watch -n1 dropbox-cli status && dropbox-cli stop'
alias e='exit'
alias g='git'
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
alias p='sudo pacman'
alias pg='ping www.google.com'
alias r='ranger'
alias R='R --quiet'
alias t='tmux'
alias timer='termdown'
alias v='vim'
alias vless="vim -u /usr/share/vim/vim74/macros/less.vim"
alias wt='watch -n1 systemctl --user list-timers'
alias x='startx'
alias z='zathura'

# Functions
ddwm() {
    # Change dwm status bar and st to dark colorscheme.
    # Mnemonic: dark dwm
    p -Rns --noconfirm dwm-git-light
    p -Rns --noconfirm st-git-light
    p -S --noconfirm dwm-git-dark st-git-dark
}

ldwm() {
    # Change dwm status bar and st to light colorscheme.
    # Mnemonic: light dwm
    p -Rns --noconfirm dwm-git-dark
    p -Rns --noconfirm st-git-dark
    p -S --noconfirm dwm-git-light st-git-light
}

lspdf() {
    ls "$@" | \
        sed 's/\.pdf$//g' | \
        sed 's/\./, /g' | \
        sed 's/-/ /g' | \
        column -t -s '_'
}

screencast() {
    ffmpeg \
        -y \
        -f x11grab \
        -video_size 1600x900 \
        -framerate 25 \
        -i "$DISPLAY" \
        -f alsa \
        -i default \
        -c:v ffvhuff \
        -c:a flac \
        output.mkv
}

# Add completions to aliases and functions
compdef g=git
compdef p=pacman
compdef t=tmux
compdef v=vim
compdef z=zathura

# colorize less, especially for manpages
export LESS_TERMCAP_mb=$(printf "\e[1;31m")     # begin blinking
export LESS_TERMCAP_md=$(printf "\e[1;31m")     # begin bold
export LESS_TERMCAP_me=$(printf "\e[0m")        # end mode
export LESS_TERMCAP_se=$(printf "\e[0m")        # end standout mode
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")  # begin standout mode (info box)
export LESS_TERMCAP_ue=$(printf "\e[0m")        # end underline
export LESS_TERMCAP_us=$(printf "\e[1;32m")     # begin underline

# environment variables
export PATH="$PATH:$HOME/.local/bin:$HOME/texlive/2018/bin/x86_64-linux:$HOME/repos/scripts"
export MANPATH="$MANPATH:$HOME/texlive/2018/texmf-dist/doc/man:$HOME/.xmonad/xmonad-git/man"
export INFOPATH="$INFOPATH:$HOME/texlive/2018/texmf-dist/doc/info"
export SUDO_EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"
export PASSWORD_STORE_X_SELECTION="primary"
export GPG_TTY=$(tty)
