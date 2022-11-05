set nocompatible
set hlsearch
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set encoding=utf-8
set number
set signcolumn=yes
set nobackup
set nowritebackup
set updatetime=300

syntax on
" https://vim.fandom.com/wiki/Indenting_source_code
filetype plugin indent on

set wildmenu
set wildmode=list:longest,full
set wildchar=<Tab>

" map leader to comma (,) instead of backslash (\)
let mapleader = ","

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

imap <C-p> <Up>
imap <C-n> <Down>

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

" map <Shift-Tab> to unindent in insert mode
inoremap <S-Tab> <C-d>

" open NERDTreee using ",nt<return>"
nnoremap <leader>nt<CR> :NERDTreeFocus<CR>

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

" remove trailing space on save
autocmd BufWritePre * :%s/\s\+$//e

" put quickfix window on the bottom
" http://stackoverflow.com/questions/6726783/changing-default-position-of-quickfix-window-in-vim
"autocmd FileType qf wincmd J
botright cwindow

" netrw tree list style
let g:netrw_liststyle=3

" DO auto-insert comments
autocmd FileType * setlocal formatoptions+=cro

" go leader key build/run
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

" favor goimports over gofmt
let g:go_fmt_command = "goimports"

" https://github.com/vim-python/python-syntax
let g:python_highlight_all=1

" enable recommended ts/sts/sw of 4
let g:python_recommended_style=1

" https://github.com/hashivim/vim-terraform/blob/master/README.md#usage
let g:terraform_fmt_on_save=1

" https://github.com/rust-lang/rust.vim#formatting-with-rustfmt
let g:rustfmt_autosave = 1

" enable FZF - https://github.com/junegunn/fzf/blob/master/README-VIM.md
set rtp+=/usr/local/opt/fzf

" Begin coc.nvim config ---------------------------------------------------------------------------
" https://github.com/neoclide/coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Also allow ctr-e, similar to fzf
inoremap <silent><expr> <c-e> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" https://github.com/neoclide/coc.nvim/issues/1026
set tagfunc=CocTagFunc

" End coc.nvim config -----------------------------------------------------------------------------
