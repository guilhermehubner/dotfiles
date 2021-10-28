-- Mark column limit for languages
vim.cmd('autocmd BufRead,BufNewFile *.go let &colorcolumn=join(range(101,2000),",")')
vim.cmd('autocmd BufRead,BufNewFile *.py let &colorcolumn=join(range(81,2000),",")')
