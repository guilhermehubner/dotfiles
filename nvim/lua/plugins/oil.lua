return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ['<CR>'] = 'actions.select',
            ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
            ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        },
        view_options = { show_hidden = true },
        use_default_keymaps = false,
    },
    init = function()
        vim.cmd('cab Ex Oil')
    end,
}
