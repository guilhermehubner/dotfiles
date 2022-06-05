vim.env.FZF_DEFAULT_COMMAND =
    'ag -l -g "" --ignore-dir=vendor/ --ignore-dir=mock/ --ignore-dir=mocks/'

vim.api.nvim_set_keymap('n', '<leader>f', ':BLines<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<CR>', {silent = true})
