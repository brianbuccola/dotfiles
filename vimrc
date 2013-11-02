" vim:      set fenc=utf-8 nu et sts=4 sw=4 ft=vim fdm=marker fmr={{{,}}}:
" file:     ~/.vimrc
" author:   Brian Buccola

" Basics {{{
set nocompatible                " use vim (not vi) settings; must come first
filetype plugin indent on       " load filetype plugin/indent files
syntax on                       " enable syntax highlighting
set modeline                    " use file-specific settings, if available
set autochdir                   " always switch to current file directory
set backup                      " make backup files
set backupdir=~/.vim/backup     " backup directory
set directory=~/.vim/tmp        " directory for swap files
set mouse=a                     " mouse support everywhere
set mousehide                   " auto-hide cursor while typing
set wildmenu                    " turn on command-line completion wild style
set wildignore=*.bak,*.jpg,*.gif,*.png,*.log,*.aux,*.out,*.bbl,*.blg
set ignorecase                  " ignore case, except...
set smartcase                   " ...when search string contains uppercase
set incsearch                   " highlight as you type search phrase
set hlsearch                    " highlight search terms
set number                      " show line numbers
set report=0                    " tell me when anything is changed via :...
set ruler                       " show current positions along bottom
set scrolloff=10                " keep 10 lines (top/bottom) for scope
set showcmd                     " show command being typed
set showmatch                   " show matching brackets
set spell                       " highlight misspelled words
set background=dark             " make vim use lighter fg colors
colorscheme molokai             " set color scheme
let g:netrw_liststyle=3         " use tree style directory listing
" }}}
" GUI Settings {{{
set guioptions-=m               " remove menu bar from gvim
set guioptions-=T               " remove toolbar from gvim
set guioptions-=r               " remove right-hand scroll bar
set guifont=Inconsolata\ 11     " use Inconsolata, size 11 font
" }}}
" Text Formatting {{{
set list                        " show real tabs (so they can be removed)
set listchars=tab:▶\ ,trail:-   " show tabs and trailing whitespace
set tabstop=8                   " real tabs are 8 columns long
set expandtab                   " no real tabs (use spaces for tabs)
set softtabstop=4               " # of spaces when hitting tab/delete
set shiftwidth=4                " # of softtabs when using cindent, <<, >>, ...
set textwidth=79                " max # of characters on each line
set autoindent                  " use indentation level of previous line
" }}}
" Autocmd's, functions, etc. {{{
" autoreload after modifying .vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" LaTeX (rubber) macro, only when editing tex file
augroup compile_tex " {
    autocmd!
    autocmd FileType tex :nnoremap <leader>c :w<CR>:!rubber --pdf --warn all %<CR>
augroup END " }

" View PDF macro; `%:r' is current file's root (base) name.
augroup view_pdf " {
    autocmd!
    autocmd FileType tex :nnoremap <leader>v :!mupdf %:r.pdf &<CR><CR>
augroup END " }

" Blog macro: convert current markdown file to html using blog script
augroup mkd2html " {
    autocmd!
    autocmd FileType mkd :nnoremap <leader>c :w<CR>:!bashdown convert ~/blog/source/%<CR>
augroup END " }
" }}}
" Mappings {{{
" change <leader> from `\' to <Space>
let mapleader=' '

" switch from insert to command mode using jj
inoremap jj <Esc>

" make `Y' work like `D', `C', etc.
nnoremap Y y$

" enable some basic movements while in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" add new line below/above current line while in normal mode,
" keeping current position. (<S-CR> only works in gvim.)
nnoremap <CR> m`o<Esc>``
nnoremap <S-CR> m`O<Esc>``

" jump to new line above current line. (Only works in gvim.)
inoremap <S-CR> <Esc>O

" prevent ctrl-U and ctrl-W from deleting stuff irrecoverably
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" map Q to gqap (reformat paragraph of text) instead of Ex mode
nnoremap Q gqap

" use K to join current line with line above, just like J does
" with line below.
nnoremap K kJ

" after searching, turn off all highlighted matches;
" basically, clearing the screen clears search highlighting, too
nnoremap <C-l> :nohlsearch<CR><C-l>

" spell check macros; `%' is current file.
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <leader>S :w<CR>:!aspell --dont-backup check %<CR>:e<CR>
" }}}
" Plugin Settings {{{
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
" }}}
