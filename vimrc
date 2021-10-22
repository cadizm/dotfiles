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
set cscopetag
set cscopetagorder=1
set autowrite
set linebreak
set nofoldenable

syntax on
" https://vim.fandom.com/wiki/Indenting_source_code
filetype plugin indent on

set wildmenu
set wildmode=list:longest,full
set wildchar=<Tab>

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

cnoremap <C-g> <Nop>
inoremap <C-g> <Esc>

" map <Command-d> to KillWord (same as meta)
inoremap <silent> <D-d> <C-r>=<SID>KillWord()<CR>
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

" http://vim.wikia.com/wiki/Editing_crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" remove trailing space on save
autocmd BufWritePre * :%s/\s\+$//e

" put quickfix window on the bottom
" http://stackoverflow.com/questions/6726783/changing-default-position-of-quickfix-window-in-vim
"autocmd FileType qf wincmd J
botright cwindow

" netrw tree list style
let g:netrw_liststyle=3

" don't auto-insert comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" go leader key build/run
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

" favor goimports over gofmt
let g:go_fmt_command = "goimports"

" https://github.com/vim-python/python-syntax
let g:python_highlight_all=1

" https://github.com/hashivim/vim-terraform/blob/master/README.md#usage
let g:terraform_fmt_on_save=1

" enable FZF - https://github.com/junegunn/fzf/blob/master/README-VIM.md
set rtp+=/usr/local/opt/fzf
