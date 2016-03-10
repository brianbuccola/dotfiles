" vim:      set fenc=utf-8 nu et sts=4 sw=4 ft=vim fdm=marker fmr={{{,}}}:
" file:     ~/.vimrc
" author:   Brian Buccola

" Pathogen (enable plugins first)
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

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
set wildignore+=*.swp,*.bak,*.jpg,*.gif,*.png
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
set splitright                  " split to the right when executing :vsplit
let g:netrw_liststyle=3         " use tree style directory listing

" change <Leader> and <LocalLeader>from `\' to <Space>
let mapleader=' '
let maplocalleader=' '

if has("gui_running")           " set color scheme for both vim and gvim
    colorscheme gruvbox
else
    colorscheme gruvbox
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
set linebreak                   " don't soft-wrap in the middle of a word
set showbreak=…                 " show `…' at the beginning of a soft-broken line
set tabstop=8                   " real tabs are 8 columns long
set expandtab                   " no real tabs (use spaces for tabs)
set softtabstop=2               " # of spaces when hitting tab/delete
set shiftwidth=2                " # of softtabs when using cindent, <<, >>, ...
set textwidth=79                " max # of characters on each line
set autoindent                  " use indentation level of previous line
set nojoinspaces                " don't add extra space after ., !, etc. when joining
set formatoptions+=j            " delete comment character when joining commented lines
" }}}
" Autocmd's, functions, etc. {{{
" autoreload after modifying .vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Use real tabs for snippets
augroup snippets " {
    autocmd!
    autocmd FileType snippet :set noet ts=8 sw=8 sts=8<CR>
augroup END " }

" Set commentstring for markdown files
augroup markdown_comments " {
    autocmd!
    autocmd FileType markdown :setlocal commentstring=<!--\ %s\ -->
augroup END " }
" }}}
" Mappings {{{
" switch from insert to command mode using jj
inoremap jj <Esc>

" AutoSaveToggle
nnoremap coa :AutoSaveToggle<CR>

" make `Y' work like `D', `C', etc.
nnoremap Y y$

" easy edit
nnoremap <leader>e :e<Space>

" easy save
nnoremap <leader>w :update<CR>

" enable some basic movements while in insert mode
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

" prevent ctrl-U and ctrl-W from deleting stuff irrecoverably
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" use <C-h> to delete entire previous word (instead of just character) in
" insert and command modes; since <C-BS> is the same as <C-h>, <C-BS> will also
" delete previous word.
map! <C-h> <C-w>

" map Q to gwap (reformat paragraph of text) instead of Ex mode.
nnoremap Q gwap

" use K to join current line with line above, just like J does
" with line below.
nnoremap K kJ

" switch to alternate buffer.
nnoremap <BS> <C-^>

" use <C-f> instead of <C-k> in insert mode to insert digraphs,
" because for some reason <C-k> isn't working.
inoremap <C-f> <C-k>

" move around soft-wrapped lines as if they were hard wrapped
noremap j gj
noremap k gk
noremap 0 g0
noremap ^ g^
noremap $ g$

" visually select the text just pasted
nnoremap gz `[v`]

" look up current word (under cursor) in online thesaurus
nnoremap <Leader>t :OnlineThesaurusCurrentWord<CR>
" }}}
" Plugin Settings {{{
" vim-markdown
let g:markdown_fenced_languages=['bash=sh', 'css', 'haskell', 'html', 'latex=tex', 'python', 'ruby']

" vim-liquid
let g:liquid_highlight_types=g:markdown_fenced_languages

" UltiSnips
let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

" LaTeX-Box
let g:LatexBox_no_mappings=1
let g:LatexBox_ignore_warnings=[]
let g:LatexBox_Folding=1
let g:LatexBox_fold_automatic=0

" vim-auto-save
let g:auto_save_no_updatetime=1

" vim-online-thesaurus
let g:online_thesaurus_map_keys=0
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
map! <C-v>ln ¬
map! <C-v>em ∅
map! <C-v>in ∈
map! <C-v>!in ∉
map! <C-v>sub ⊆
map! <C-v>cap ∩
map! <C-v>cup ∪
map! <C-v>[[ ⟦
map! <C-v>]] ⟧
map! <C-v>box □
map! <C-v>dia ◇
map! <C-v>lb ⟨
map! <C-v>rb ⟩
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
map! <C-v>? ʔ
" other
map! <C-v>" ˈ
map! <C-v>"" ˌ
" }}}
