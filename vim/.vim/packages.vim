function! PackInit() abort
    " Load minpac.
    packadd minpac

    " Add minpac. Must have {'type': 'opt'} so that it can be loaded with pacadd.
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Initialize minpac.
    call minpac#init()

    " Add additional packages.
    call minpac#add('SirVer/ultisnips')
    call minpac#add('bradford-smith94/quick-scope')
    call minpac#add('coderifous/textobj-word-column.vim')
    call minpac#add('honza/vim-snippets', {'type': 'opt'})
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('junegunn/goyo.vim')
    call minpac#add('junegunn/limelight.vim')
    call minpac#add('junegunn/vim-emoji')
    call minpac#add('lervag/vimtex')
    call minpac#add('machakann/vim-highlightedyank')
    call minpac#add('morhetz/gruvbox')
    call minpac#add('plasticboy/vim-markdown')
    call minpac#add('reedes/vim-textobj-quote')
    call minpac#add('timakro/vim-searchant')
    call minpac#add('tommcdo/vim-exchange')
    call minpac#add('tommcdo/vim-lion')
    call minpac#add('tommcdo/vim-nowchangethat')
    call minpac#add('tpope/vim-abolish')
    call minpac#add('tpope/vim-characterize')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('tpope/vim-vinegar')
    call minpac#add('vim-pandoc/vim-pandoc-syntax')
    call minpac#add('vim-scripts/ReplaceWithRegister')
    call minpac#add('wellle/targets.vim')
endfunction

" Package commands.
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac  | call minpac#status()
