syntax enable

" We need to make sure that vim is not attempting to retain compatibility with vi, its predecessor. This is a vundle requirement. When vim attempts to be compatible, it disables most of the features that make it worth using over vi.

set nocompatible

" Tabs
set tabstop=4 " columns taken by tab character
set softtabstop=4 " fixes backspace issue
set shiftwidth=4 " equivalent spaces when pressing tab key 
set expandtab " convert tab to spaces

" Indents
set autoindent
set cindent

" Show cmd
set showcmd

" Indent based on filetype
filetype indent on

set incsearch " search as characters are entered
set hlsearch " highlight matches

" highlight last inserted text
nnoremap gV `[v`]

" backup files
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
