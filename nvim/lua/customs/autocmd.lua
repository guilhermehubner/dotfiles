local group = vim.api.nvim_create_augroup('Customs', { clear = true })

-- Syntax for file extensions
vim.api.nvim_create_autocmd(
    { 'BufRead', 'BufNewFile' },
    { group = group, pattern = '*.qtpl', command = 'set filetype=html' }
)

-- Remove useless spaces at EOF on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = '*',
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

-- Mark column limit for languages
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = group,
    pattern = '*.go',
    command = 'let &colorcolumn=join(range(101,2000),",")',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = group,
    pattern = '*.py',
    command = 'let &colorcolumn=join(range(81,2000),",")',
})
