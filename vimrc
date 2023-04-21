set nocompatible
set hlsearch
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set ruler
set ls=2
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

syntax enable
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

function! <SID>KillWord()
  if col('.') > strlen(getline('.'))
    return "\<Del>\<C-o>\"_dw"
  else
    return "\<C-o>\"_dw"
  endif
endfunction

function! <SID>KillLine()
  if col('.') > strlen(getline('.'))
    " At EOL; join with next line
    return "\<Del>"
  else
    " Not at EOL; kill until end of line
    return "\<C-o>\"_d$"
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

" favor goimports over gofmt
let g:go_fmt_command = "goimports"

" https://github.com/vim-python/python-syntax
let g:python_highlight_all = 1

" enable recommended ts/sts/sw of 4
let g:python_recommended_style = 1

" https://github.com/hashivim/vim-terraform/blob/master/README.md#usage
let g:terraform_fmt_on_save = 1

" https://github.com/rust-lang/rust.vim#formatting-with-rustfmt
let g:rustfmt_autosave = 1

" https://github.com/lifepillar/pgsql.vim
let g:sql_type_default = 'pgsql'

" configure ack to use rg
let g:ackprg = 'rg --vimgrep --smart-case'

" empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

cnoreabbrev ACk Ack

" enable FZF - https://github.com/junegunn/fzf/blob/master/README-VIM.md
set rtp+=/usr/local/opt/fzf

" https://github.com/srstevenson/vim-picker
let g:picker_custom_find_executable = 'fd'
let g:picker_selector_executable = 'fzy'


" Begin vim-plug config ---------------------------------------------------------------------------
"
" https://github.com/junegunn/vim-plug
"
" The default plugin directories:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
"
" :PlugInstall
"
call plug#begin()

Plug 'mileszs/ack.vim'
Plug 'cadizm/dracula-vim'
Plug 'cespare/vim-toml', {'branch': 'main'}
Plug 'doums/darcula'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }  " Needs node and yarn
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mracos/mermaid.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'tyru/open-browser.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'srstevenson/vim-picker'
Plug 'vim-scripts/scratch.vim'

call plug#end()

" End vim-plug config -----------------------------------------------------------------------------


" Begin coc.nvim config ---------------------------------------------------------------------------

" https://github.com/neoclide/coc.nvim
" https://github.com/neoclide/coc.nvim/blob/master/doc/coc.txt

" Use Tab and Return to confirm completion
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Use <C-space> to trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
if exists(':CocActionAsync')
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" https://github.com/neoclide/coc.nvim/issues/1026
set tagfunc=CocTagFunc

" End coc.nvim config -----------------------------------------------------------------------------

" Leader shortcuts
"
" Go build, run, test
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)

" Find file
nnoremap <leader>ff <Plug>(PickerEdit)

" Find buffer
nnoremap <leader>bb <Plug>(PickerBuffer)

" Adjust buffer window width by +/- 1
" This can also be done by:
"   ctrl-w >
"   ctrl-w <
nnoremap <leader>= :vertical resize +1<CR>
nnoremap <leader>- :vertical resize -1<CR>

" Adjust buffer window width by +/- 5
" This can also be done by:
"   5 ctrl-w >
"   5 ctrl-w <
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>_ :vertical resize -5<CR>

" Open NERDTreee
nnoremap <leader>nt :NERDTreeFocus<CR>

" Open file in GitHub
nnoremap <leader>gh :OpenGithubFile<CR>
