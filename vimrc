" vim:      set fenc=utf-8 nu et sw=4 ft=vim:
" file:     ~/.vimrc
" author:   Brian Buccola



" ========
"  Basics
" ========

set nocompatible                " use vim settings, not vi-compatible ones
                                " this must come before all other settings
set background=dark             " make vim use lighter fg colors
syntax on
set modeline                    " use file-specific settings, if available
                                " add /usr/share/vim/vimfiles to $runtimepath..
"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
filetype plugin indent on       " load filetype plugin/indent files
set autochdir                   " always switch to current file directory
set backup                      " make backup files
set backupdir=~/.vim/backup     " backup directory
set directory=~/.vim/tmp        " directory for swap files
set mouse=a                     " mouse support everywhere
set mousehide                   " auto-hide cursor while typing
set wildmenu                    " turn on command-line completion wild style
                                " ignore these file extensions...
set wildignore=*.bak,*.jpg,*.gif,*.png,*.log,*.aux,*.out,*.bbl,*.blg
set ignorecase                  " ignore case, except...
set smartcase                   " ...when search string contains uppercase
set incsearch                   " highlight as you type search phrase
set list                        " show real tabs (so they can be removed)
set listchars=tab:>-,trail:-    " show tabs and trailing
set number                      " show line numbers
set report=0                    " tell me when anything is changed via :...
set ruler                       " show current positions along bottom
set scrolloff=10                " keep 10 lines (top/bottom) for scope
set showcmd                     " show command being typed
set showmatch                   " show matching brackets
" set statusline=
colorscheme molokai             " set color scheme



" =================
"  Text Formatting
" =================

set expandtab                   " no real tabs (use spaces for tabs)
set softtabstop=4               " # of spaces when hitting tab/delete
set tabstop=8                   " real tabs are 8, shown with set list
set shiftwidth=4                " # of softtabs when using cindent, <<, >>, ...
set textwidth=79                " max # of characters on each line



" ============================
"  Autocmd's, functions, etc.
" ============================

" autoreload after modifying .vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" remove trailing whitespace
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" call TrimWhiteSpace() just before write
" autocmd FileWritePre    * :call TrimWhiteSpace()
" autocmd FileAppendPre   * :call TrimWhiteSpace()
" autocmd FilterWritePre  * :call TrimWhiteSpace()
" autocmd BufWritePre     * :call TrimWhiteSpace()



" ==========
"  Mappings
" ==========

" change <leader> from `\' to <Space>
let mapleader=' '

" switch from insert to command mode using jj
inoremap jj <Esc>

" make `Y' work like `D', `C', etc.
nnoremap Y y$

" enable some basic movements while in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" prevent ctrl-U and ctrl-W from deleting stuff irrecoverably
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" map Q to gqap (reformat paragraph of text) instead of Ex mode
nnoremap Q gqap

" use K to join current line with line above, just like J does
" with line below.
nnoremap K kJ

" spell check macro; `%' is current file.
nnoremap <leader>s :w<CR>:!aspell --dont-backup check %<CR>:e<CR>

" LaTeX (rubber) macro
nnoremap <leader>t :w<CR>:!rubber --pdf --warn all %<CR>

" View PDF macro; `%:r' is current file's root (base) name.
nnoremap <leader>v :!mupdf %:r.pdf &<CR><CR>



" =================
"  Plugin Settings
" =================

" Pathogen
call pathogen#infect()

" Syntastic
let g:syntastic_mode_map={ 'mode': 'active',
                         \ 'active_filetypes': [],
                         \ 'passive_filetypes': ['tex'] }

" UltiSnips
let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

" LaTeX
set grepprg=grep\ -nH\ $*       " grep will sometimes skip displaying file
                                " name if you search in a singe file. This will
                                " confuse Latex-Suite. Set your grep program to
                                " always generate a file-name.
let g:tex_flavor='latex'        " set filetype of empty tex files to latex
                                " instead of plaintex
let g:Tex_DefaultTargetFormat='pdf' " Use pdflatex instead of latex
                                    " to compile.
let g:Tex_ViewRule_pdf='mupdf'  " choose which pdf viewer to use



" ==============
"  GUI Settings
" ==============

set guioptions-=m               " remove menu bar from gvim
set guioptions-=T               " remove toolbar from gvim
set guioptions-=r               " remove right-hand scroll bar
