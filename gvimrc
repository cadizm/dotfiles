set lines=60
set columns=80
set guioptions-=T

winpos 10 30
syntax enable

set guifont=Menlo-Regular:h10
colorscheme mc

autocmd FileType java packadd! dracula
autocmd FileType java colorscheme dracula
autocmd FileType java set guifont=Monaco:h10
