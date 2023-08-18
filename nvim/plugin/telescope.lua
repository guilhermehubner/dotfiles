vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gi', ':Telescope lsp_implementations<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gr', ':Telescope lsp_references<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope live_grep<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>F', ':Telescope current_buffer_fuzzy_find<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ts', ':Telescope treesitter<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tp', ':Telescope resume<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>te', ':Telescope diagnostics<CR>', {})

require('telescope').setup{
	defaults = {
		file_ignore_patterns = { "^vendor/" }
	}
}
