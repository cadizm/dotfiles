
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
set hidden
set showcmd
set history=1000
set winaltkeys=no

"set wildchar=<Tab>
set wildmenu
set wildmode=list:longest,full

map <C-Tab> :tabn<CR>
map <C-Tab> :tabp<CR>

" emacs-ish movement
imap <C-a> <Esc>0i
imap <C-e> <Esc>$a
imap <C-b> <Esc>ha
imap <C-f> <Esc>la
imap <M-b> <Esc>bi
imap <M-f> <Esc>wwi

" these need more tweaking
map <M-d> "_dw
imap <M-d> <Esc>lcw
imap <C-k> <Esc>lDa
imap <M-BS> <Esc>bdwa

autocmd FileType lisp setlocal tabstop=2 shiftwidth=2
