return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ['<CR>'] = { 'actions.select', desc = 'Oil: Open entry' },
            ['<C-s>'] = {
                'actions.select',
                opts = { vertical = true },
                desc = 'Oil: Open entry in vertical split',
            },
            ['<C-h>'] = {
                'actions.select',
                opts = { horizontal = true },
                desc = 'Oil: Open entry in horizontal split',
            },
        },
        view_options = { show_hidden = true },
        use_default_keymaps = false,
    },
    init = function()
        vim.keymap.set('ca', 'Ex', function()
            return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == 'Ex') and 'Oil' or 'Ex'
        end, { expr = true, desc = 'Open Oil with :Ex' })
    end,
}
