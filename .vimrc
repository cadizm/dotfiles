
set nocompatible
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
map <C-\> :Lid<CR>

map <M-d> "_dw

" emacs-ish movement taken from vimacs
" See http://www.algorithm.com.au/code/vimacs

cmap <C-a> <Home>
imap <C-a> <Home>
omap <C-a> <Home>

cmap <C-e> <End>
imap <C-e> <End>
omap <C-e> <End>

cmap <C-b> <Left>
imap <C-b> <Left>
omap <C-b> <Left>

cmap <C-f> <Right>
imap <C-f> <Right>
omap <C-f> <Right>

cnoremap <M-b> <S-Left>
inoremap <M-b> <C-Left>
onoremap <M-b> <C-Left>

cnoremap <M-f> <S-Right>
inoremap <M-f> <C-o>e<Right>
onoremap <M-f> e<Right>

cnoremap <C-d> <Del>
inoremap <C-d> <Del>
onoremap <C-d> <Del>

cnoremap <M-BS> <C-w>
inoremap <M-BS> <C-w>

inoremap <silent> <M-d> <C-r>=<SID>KillWord()<CR>
inoremap <silent> <C-k> <C-r>=<SID>KillLine()<CR>

function! <SID>KillWord()
  if col('.') > strlen(getline('.'))
    return "\<Del>\<C-o>dw"
  else
    return "\<C-o>dw"
  endif
endfunction

function! <SID>KillLine()
  if col('.') > strlen(getline('.'))
    " At EOL; join with next line
    return "\<Del>"
  else
    " Not at EOL; kill until end of line
    return "\<C-o>d$"
  endif
endfunction
