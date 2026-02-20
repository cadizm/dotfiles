set lines=90
set columns=150

set guioptions-=T
set guifont=Monaco:h13
set guicursor+=a:blinkon0  " disable blinking cursor

winpos 1320 25
syntax enable

" Monitor flickering
"packadd! dracula
"colorscheme dracula

" https://github.com/EdenEast/nightfox.nvim?tab=readme-ov-file
packadd! carbonfox
colorscheme carbonfox
