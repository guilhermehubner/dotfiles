vim.g.vimspector_enable_mappings = 'HUMAN'

vim.keymap.set('n', '<leader>n', ':call vimspector#StepOver()<CR>', {silent = true})
vim.keymap.set('n', '<leader>m', ':call vimspector#StepInto()<CR>', {silent = true})
vim.keymap.set('n', '<leader>b', ':call vimspector#ToggleBreakpoint()<CR>', {silent = true})
vim.keymap.set('n', '<leader>dd', ':call vimspector#Launch()<CR>', {silent = true})
vim.keymap.set('n', '<leader>ds', ':call vimspector#Stop()<CR>', {silent = true})
vim.keymap.set('n', '<leader>dr', ':call vimspector#Reset()<CR>', {silent = true})
vim.keymap.set('n', '<leader>c', ':call vimspector#Continue()<CR>', {silent = true})
