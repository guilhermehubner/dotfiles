-- Syntax for file extensions
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'},
                            {pattern = '*.qtpl', command = 'set filetype=html'})

-- Remove useless spaces at EOF on save
vim.api.nvim_create_autocmd('BufWritePre', {pattern = '*', command = '%s/\\s\\+$//e'})
