set nocompatible
set linebreak
set hlsearch
set incsearch
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set ruler
set vb
set ignorecase
set smartcase
set shellslash
set hidden
set backup
set directory=~/.backup
set backupdir=~/.backup
set grepprg=grep\ -nH\ $*
set history=1000

"set wildchar=<Tab>
set wildmenu
set wildmode=list:longest,full

map <C-Tab>   :tabn<CR>
map <C-S-Tab> :tabp<CR>

" map meta-d to `delete word to blackhole register' a l emacs (normal mode)
map <M-d> "_dw

" map meta-backspace to `delete previous word' a l emacs (insert mode)
imap <M-BS> <Esc>bdwa

autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType xml  setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType lisp setlocal tabstop=2 shiftwidth=2
