require'lualine'.setup {
    options = {theme = 'dracula'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', {'diagnostics', sources = {'nvim_lsp'}}},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
    }
}
