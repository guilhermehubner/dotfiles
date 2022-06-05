vim.env.FZF_DEFAULT_COMMAND =
    'ag -l -g "" --ignore-dir=vendor/ --ignore-dir=mock/ --ignore-dir=mocks/'

vim.keymap.set('n', '<leader>f', ':BLines<CR>', {silent = true})
vim.keymap.set('n', '<C-p>', ':FZF<CR>', {silent = true})
