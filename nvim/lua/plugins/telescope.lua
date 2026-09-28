return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<C-p>', ':Telescope find_files<CR>', desc = 'Telescope: Find files' },
        {
            '<leader>gi',
            ':Telescope lsp_implementations<CR>',
            desc = 'Telescope: LSP implementations',
        },
        { '<leader>gr', ':Telescope lsp_references<CR>', desc = 'Telescope: LSP references' },
        { '<leader>f', ':Telescope live_grep<CR>', desc = 'Telescope: Grep in project' },
        {
            '<leader>F',
            ':Telescope current_buffer_fuzzy_find<CR>',
            desc = 'Telescope: Fuzzy find in buffer',
        },
        { '<leader>ts', ':Telescope treesitter<CR>', desc = 'Telescope: Treesitter symbols' },
        { '<leader>tp', ':Telescope resume<CR>', desc = 'Telescope: Resume last picker' },
        { '<leader>te', ':Telescope diagnostics<CR>', desc = 'Telescope: Diagnostics' },
        { '<leader>km', ':Telescope keymaps<CR>', desc = 'Telescope: Search keymaps' },
        {
            '<leader>tf',
            ':lua require("telescope.builtin").lsp_document_symbols({ symbols = { "method", "function" } })<CR>',
            desc = 'Telescope: Functions and methods in buffer',
        },
    },
    opts = { defaults = { file_ignore_patterns = { '^vendor/' } } },
}
