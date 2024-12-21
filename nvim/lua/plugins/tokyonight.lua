return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.termguicolors = true
        vim.cmd([[colorscheme tokyonight-storm]])

        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
    end,
}
