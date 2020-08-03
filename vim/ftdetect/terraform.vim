autocmd BufNewFile,BufRead *.tf setfiletype terraform
autocmd BufNewFile,BufRead *.tfvars setfiletype terraform
autocmd FileType terraform setlocal sw=2 ts=2
