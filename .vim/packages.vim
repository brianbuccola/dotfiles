" Package commands.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Make sure minpac is loaded.
if !exists('*minpac#init')
    finish
endif

" Initialize minpac.
call minpac#init()

" Add minpac. Must have {'type': 'opt'} so that it can be loaded with pacadd.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add additional packages.
call minpac#add('PotatoesMaster/i3-vim-syntax')
call minpac#add('SirVer/ultisnips')
call minpac#add('beloglazov/vim-online-thesaurus')
call minpac#add('bradford-smith94/quick-scope')
call minpac#add('coderifous/textobj-word-column.vim')
call minpac#add('chriskempson/base16-vim')
call minpac#add('honza/vim-snippets')
call minpac#add('junegunn/fzf.vim')
call minpac#add('kana/vim-textobj-user')
call minpac#add('lervag/vimtex')
call minpac#add('morhetz/gruvbox')
call minpac#add('nanotech/jellybeans.vim')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('reedes/vim-textobj-quote')
call minpac#add('timakro/vim-searchant')
call minpac#add('tmhedberg/matchit')
call minpac#add('tomasr/molokai')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tommcdo/vim-lion')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-characterize')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-scripts/ReplaceWithRegister')
call minpac#add('vim-scripts/vim-auto-save')
call minpac#add('wellle/targets.vim')
