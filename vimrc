" vim:      set fenc=utf-8 nu et sts=4 sw=4 ft=vim fdm=marker fmr={{{,}}}:
" file:     ~/.vimrc
" author:   Brian Buccola

" Pathogen (enable plugins first)
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Basics {{{
set nocompatible                " Use vim (not vi) settings; must come first.
filetype plugin indent on       " Load filetype plugin/indent files.
syntax on                       " Enable syntax highlighting.
set modeline                    " Use file-specific settings, if available.
set autochdir                   " Always switch to current file directory.
set backup                      " Make backup files.
set backupdir=~/.vim/backup     " Backup directory.
set directory=~/.vim/tmp        " Directory for swap files.
set mouse=a                     " Mouse support everywhere.
set mousehide                   " Auto-hide cursor while typing.
set wildmode=list:longest,full  " Make completion more like zsh.
set wildmenu                    " Turn on command-line completion wild style.
set wildignore+=*.swp,*.bak,*.jpg,*.gif,*.png
set ignorecase                  " Ignore case, except...
set smartcase                   " ...when search string contains uppercase.
set incsearch                   " Highlight as you type search phrase.
set hlsearch                    " Highlight search terms.
set number                      " Show line numbers.
set report=0                    " Tell me when anything is changed via :...
set ruler                       " Show current positions along bottom.
set scrolloff=5                 " Keep 5 lines (top/bottom) for scope.
set showcmd                     " Show command being typed.
set showmatch                   " Show matching brackets.
set spell                       " Highlight misspelled words.
set spellcapcheck=              " Don't highlight uncapitalized first word.
set complete+=kspell            " Use <C-n> and <C-p> to get suggested spelling completions.
set splitright                  " Split to the right when executing :vsplit.
let g:netrw_liststyle=3         " Use tree style directory listing.

" Change <Leader> and <LocalLeader>from `\' to <Space>.
let mapleader=' '
let maplocalleader=' '

if has("gui_running")           " Set color scheme for both vim and gvim.
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox
else
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox
endif
set background=dark             " Use dark bg color and light fg colors.
" }}}
" GUI Settings {{{
set guioptions-=m               " Remove menu bar from gvim.
set guioptions-=T               " Remove toolbar from gvim.
set guioptions-=r               " Remove right-hand scroll bar.
set guioptions-=L               " Remove left-hand scroll bar even when there is a vertically split window.
set guifont=Terminus\ 12        " Use Terminus, size 12 font.
" }}}
" Text Formatting {{{
set list                        " Show real tabs (so they can be removed).
set listchars=tab:▶\ ,trail:-   " Show tabs and trailing whitespace.
set linebreak                   " Don't soft-wrap in the middle of a word.
set showbreak=…                 " Show `…' at the beginning of a soft-broken line.
set tabstop=8                   " Real tabs are 8 columns long.
set expandtab                   " No real tabs (use spaces for tabs).
set softtabstop=2               " Set # of spaces when hitting tab/delete.
set shiftwidth=2                " Set # of softtabs when using cindent, <<, >>, ...
set textwidth=80                " Set max # of characters on each line.
set autoindent                  " Use indentation level of previous line.
set nojoinspaces                " Don't add extra space after ., !, etc. when joining.
set formatoptions+=j            " Delete comment character when joining commented lines.
" }}}
" Autocmd's, functions, etc. {{{
" Autoreload after modifying .vimrc.
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Use real tabs for snippets.
augroup snippets " {
    autocmd!
    autocmd FileType snippet setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
augroup END " }

" Set commentstring for markdown files.
augroup markdown_comments " {
    autocmd!
    autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
augroup END " }

" Add some useful format options for writing prose.
augroup prose_formatoptions " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w                  " Add trailing white space; to be used with mutt's 'text_flowed' option.
    autocmd FileType text,mail,markdown setlocal formatoptions+=a    " Automatically reformat paragraph whenever text is inserted or deleted.
    autocmd FileType text,mail,markdown setlocal formatoptions-=l    " Format option 'a' overrides 'l' anyway.
    autocmd FileType text,mail,markdown setlocal formatoptions+=n    " Format numbered lists by including indentation.
augroup END " }
" }}}
" Mappings {{{
" Switch from insert to command mode using jj.
inoremap jj <Esc>

" Add vim-unimpaired-like keybinding for AutoSaveToggle.
nnoremap coa :AutoSaveToggle<CR>

" Make `Y' work like `D', `C', etc.
nnoremap Y y$

" Easy edit.
nnoremap <leader>e :e<Space>

" Easy save.
nnoremap <leader>w :update<CR>

" Enable some basic movements while in insert mode.
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

" Prevent ctrl-U and ctrl-W from deleting stuff irrecoverably.
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Use <C-h> to delete entire previous word (instead of just character) in insert
" and command modes. Since <C-BS> is the same as <C-h>, <C-BS> will also delete
" previous word.
map! <C-h> <C-w>

" Map Q to gwap (reformat paragraph of text) instead of Ex mode.
nnoremap Q gwap

" Use K to join current line with line above, just like J does with line below.
nnoremap K kJ

" Switch to alternate buffer.
nnoremap <BS> <C-^>

" Use <C-f> instead of <C-k> in insert mode to insert digraphs, because for some
" reason <C-k> isn't working.
inoremap <C-f> <C-k>

" Move around soft-wrapped lines as if they were hard wrapped.
noremap j gj
noremap k gk
noremap 0 g0
noremap ^ g^
noremap $ g$

" Visually select the text just pasted.
nnoremap gz `[v`]

" Look up current word (under cursor) in online thesaurus.
nnoremap <Leader>t :OnlineThesaurusCurrentWord<CR>

" Edit current command in command-line window.
cnoremap <C-e> <C-f>
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
let g:LatexBox_ignore_warnings=[]
let g:LatexBox_Folding=1
let g:LatexBox_fold_automatic=0

" vim-auto-save
let g:auto_save_no_updatetime=1

" vim-online-thesaurus
let g:online_thesaurus_map_keys=0
" }}}
" Greek {{{
" (Thanks to connermcd for these.)
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
" Vowels
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
" Consonants
map! <C-v>N ŋ
map! <C-v>r ɹ
map! <C-v>mf ɱ
map! <C-v>eth ð
map! <C-v>S ʃ
map! <C-v>Z ʒ
map! <C-v>T θ
map! <C-v>? ʔ
" Other
map! <C-v>" ˈ
map! <C-v>"" ˌ
" }}}
