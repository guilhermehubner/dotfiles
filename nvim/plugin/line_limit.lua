-- Mark column limit for languages
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.go',
    command = 'let &colorcolumn=join(range(101,2000),",")'
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.py',
    command = 'let &colorcolumn=join(range(81,2000),",")'
})
