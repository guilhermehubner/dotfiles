return {
    'saghen/blink.cmp',
    version = '*',
    event = 'InsertEnter',
    opts = {
        keymap = { preset = 'enter' },
        appearance = {
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
        },
        signature = { enabled = true },
        sources = {
            -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
            -- 'lazydev' added (and ranked first via score_offset): in Lua files it completes
            -- require() module names and Neovim/plugin APIs from lazydev.nvim.
            default = { 'lazydev', 'lsp', 'path', 'snippets' },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
            },
        },
    },
}
