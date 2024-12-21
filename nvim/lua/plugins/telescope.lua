return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<C-p>', ':Telescope find_files<CR>' },
        { '<leader>gi', ':Telescope lsp_implementations<CR>' },
        { '<leader>gr', ':Telescope lsp_references<CR>' },
        { '<leader>f', ':Telescope live_grep<CR>' },
        { '<leader>F', ':Telescope current_buffer_fuzzy_find<CR>' },
        { '<leader>ts', ':Telescope treesitter<CR>' },
        { '<leader>tp', ':Telescope resume<CR>' },
        { '<leader>te', ':Telescope diagnostics<CR>' },
        {
            '<leader>tf',
            ':lua require("telescope.builtin").lsp_document_symbols({ symbols = { "method", "function" } })<CR>',
        },
    },
    opts = { defaults = { file_ignore_patterns = { '^vendor/' } } },
}
