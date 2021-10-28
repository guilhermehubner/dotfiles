-- Syntax for file extensions
vim.cmd('autocmd BufRead,BufNewFile *.qtpl set filetype=html')

-- Remove useless spaces at EOF on save
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e')
