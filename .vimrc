syntax enable

" We need to make sure that vim is not attempting to retain compatibility with vi, its predecessor. This is a vundle requirement. When vim attempts to be compatible, it disables most of the features that make it worth using over vi.

set nocompatible
filetype plugin indent on

" Add vundle to the runtime path
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree.git'
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plugin 'Buffergator'

" Rename file
Plugin 'danro/rename.vim.git'

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

filetype indent on      " load filetype-specific indent files

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
