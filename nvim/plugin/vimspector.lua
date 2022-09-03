vim.g.vimspector_enable_mappings = 'HUMAN'

vim.api.nvim_set_keymap('n', '<leader>n', ':call vimspector#StepOver()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>m', ':call vimspector#StepInto()<CR>', {silent = true})
vim.api
    .nvim_set_keymap('n', '<leader>b', ':call vimspector#ToggleBreakpoint()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>dd', ':call vimspector#Launch()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ds', ':call vimspector#Stop()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>dr', ':call vimspector#Reset()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>c', ':call vimspector#Continue()<CR>', {silent = true})
