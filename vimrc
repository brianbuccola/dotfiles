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
set wildmode=list:longest,full  " make completion more like zsh
set wildmenu                    " turn on command-line completion wild style
set wildignore=*.bak,*.jpg,*.gif,*.png,*.log,*.aux,*.out,*.bbl,*.blg
set ignorecase                  " ignore case, except...
set smartcase                   " ...when search string contains uppercase
set incsearch                   " highlight as you type search phrase
set hlsearch                    " highlight search terms
set number                      " show line numbers
set report=0                    " tell me when anything is changed via :...
set ruler                       " show current positions along bottom
set scrolloff=5                 " keep 5 lines (top/bottom) for scope
set showcmd                     " show command being typed
set showmatch                   " show matching brackets
set spell                       " highlight misspelled words
set spellcapcheck=              " don't highlight uncapitalized first word
set complete+=kspell            " use <C-n> and <C-p> to get suggested spelling completions
set background=dark             " make vim use lighter fg colors
let g:netrw_liststyle=3         " use tree style directory listing

if has("gui_running")           " set color scheme for both vim and gvim
    colorscheme solarized
else
    colorscheme molokai
endif
" }}}
" GUI Settings {{{
set guioptions-=m               " remove menu bar from gvim
set guioptions-=T               " remove toolbar from gvim
set guioptions-=r               " remove right-hand scroll bar
set guioptions-=L               " remove left-hand scroll bar even when there is a vertically split window
set guifont=Inconsolata\ 11     " use Inconsolata, size 11 font
" }}}
" Text Formatting {{{
set list                        " show real tabs (so they can be removed)
set listchars=tab:▶\ ,trail:-   " show tabs and trailing whitespace
set tabstop=8                   " real tabs are 8 columns long
set expandtab                   " no real tabs (use spaces for tabs)
set softtabstop=2               " # of spaces when hitting tab/delete
set shiftwidth=2                " # of softtabs when using cindent, <<, >>, ...
set textwidth=79                " max # of characters on each line
set autoindent                  " use indentation level of previous line
set nojoinspaces                " don't add extra space after ., !, etc. when joining
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
    autocmd FileType tex :nnoremap <leader>c :w<CR>:!latexmk -pdf %<CR>
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

augroup snippets " {
    autocmd!
    autocmd FileType snippet :set noet ts=8 sw=8 sts=8<CR>
augroup END " }
" }}}
" Mappings {{{
" change <leader> from `\' to <Space>
let mapleader=' '

" switch from insert to command mode using jj
inoremap jj <Esc>

" easy write
inoremap jw <Esc>:w<CR>a
nnoremap <leader>jw :w<CR>

" AutoSaveToggle
nnoremap <leader>a :AutoSaveToggle<CR>

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

" use <C-BS> to delete entire previous word in insert mode
inoremap <C-BS> <C-w>

" map Q to gqap (reformat paragraph of text) instead of Ex mode
nnoremap Q gqap

" use K to join current line with line above, just like J does
" with line below.
nnoremap K kJ

" after searching, turn off all highlighted matches;
" basically, clearing the screen clears search highlighting, too
noremap <C-l> :nohlsearch<CR><C-l>

" spell check macros; `%' is current file.
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <leader>S :w<CR>:!aspell --dont-backup check %<CR>:e<CR>

" switch to alternate buffer.
nnoremap <BS> <C-^>
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

" LaTeX-Box
let g:LatexBox_Folding=1
" }}}
" Greek {{{
" (thanks to connermcd for these)
map! <C-v>GA Γ
map! <C-v>DE Δ
map! <C-v>TH Θ
map! <C-v>LA Λ
map! <C-v>XI Ξ
map! <C-v>PI Π
map! <C-v>SI Σ
map! <C-v>PH Φ
map! <C-v>PS Ψ
map! <C-v>OM Ω
map! <C-v>al α
map! <C-v>be β
map! <C-v>ga γ
map! <C-v>de δ
map! <C-v>ep ε
map! <C-v>ze ζ
map! <C-v>et η
map! <C-v>th θ
map! <C-v>io ι
map! <C-v>ka κ
map! <C-v>la λ
map! <C-v>mu μ
map! <C-v>xi ξ
map! <C-v>pi π
map! <C-v>rh ρ
map! <C-v>si σ
map! <C-v>ta τ
map! <C-v>ps ψ
map! <C-v>om ω
map! <C-v>ph ϕ
" }}}
" Math {{{
map! <C-v>-> →
map! <C-v>< ⇌
map! <C-v>n ↑
map! <C-v>v ↓
map! <C-v>= ∝
map! <C-v>~ ≈
map! <C-v>!= ≠
map! <C-v>!> ⇸
map! <C-v>~> ↝
map! <C-v>>= ≥
map! <C-v><= ≤
map! <C-v>0 °
map! <C-v>ce ¢
map! <C-v>* •
map! <C-v>co ⌘
map! <C-v>fa ∀
map! <C-v>ex ∃
map! <C-v>& ∧
map! <C-v>or ∨
map! <C-v>em ∅
map! <C-v>in ∈
map! <C-v>!in ∉
map! <C-v>sub ⊆
" }}}
" IPA {{{
" vowels
map! <C-v>-i ɨ
map! <C-v>-u ʉ
map! <C-v>m ɯ
map! <C-v>I ɪ
map! <C-v>Y ʏ
map! <C-v>U ʊ
map! <C-v>/o ø
map! <C-v>@ ə
map! <C-v>E ɛ
map! <C-v>oe œ
map! <C-v>^ ʌ
map! <C-v>O ɔ
map! <C-v>ae æ
map! <C-v>A ɑ
" consonants
map! <C-v>N ŋ
map! <C-v>r ɹ
map! <C-v>mf ɱ
map! <C-v>eth ð
map! <C-v>S ʃ
map! <C-v>Z ʒ
map! <C-v>T θ
" }}}
