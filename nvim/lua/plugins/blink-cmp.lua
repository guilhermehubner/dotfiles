return {
    'saghen/blink.cmp',
    version = '*',
    event = 'InsertEnter',
    opts = {
        keymap = { preset = 'enter' },
        appearance = {
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
        },
        signature = { enabled = true },
        sources = {
            -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
            default = { 'lsp', 'path', 'snippets' },
            -- Disable cmdline completions
            cmdline = {},
        },
    },
}
