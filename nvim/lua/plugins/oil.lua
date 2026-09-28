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
        vim.keymap.set('ca', 'Ex', function()
            return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == 'Ex') and 'Oil' or 'Ex'
        end, { expr = true })
    end,
}
