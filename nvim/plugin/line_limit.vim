" Mark column limit for languages
autocmd BufRead,BufNewFile *.go let &colorcolumn=join(range(101,2000),",")
autocmd BufRead,BufNewFile *.py let &colorcolumn=join(range(81,2000),",")
