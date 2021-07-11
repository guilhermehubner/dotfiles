" Syntax for file extensions
autocmd BufRead,BufNewFile *.qtpl set filetype=html

" Remove useless spaces at EOF on save
autocmd BufWritePre * %s/\s\+$//e
