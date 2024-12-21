return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = { keymaps = { ['<CR>'] = 'actions.select' }, use_default_keymaps = false },
    init = function()
        vim.cmd('cab Ex Oil')
    end,
}
