-- PluginManager ( https://github.com/wbthomason/packer.nvim )
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Snippet
    use {'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip'}

    -- LSP
    use {
        'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-path'
    }

    -- Navigation / Finder
    use {'nvim-telescope/telescope.nvim', branch = '0.1.x'}

    -- Dependency for some plugins
    use 'nvim-lua/plenary.nvim'

    -- Go Coverage
    use {'rafaelsq/nvim-goc.lua', {as = 'nvim-goc'}}

    -- UI plugins
    use {'folke/tokyonight.nvim'}

    -- Highlight search only when searching
    use 'romainl/vim-cool'

    -- Git
    use {'airblade/vim-gitgutter', 'tpope/vim-fugitive'}

    -- Highlights Syntax
    use 'nvim-treesitter/nvim-treesitter'

    -- Breakpoint support
    use 'puremourning/vimspector'

    -- Status Line
    use 'nvim-lualine/lualine.nvim'

    -- Formatters and linters
    use 'stevearc/conform.nvim'
    use 'mfussenegger/nvim-lint'
end)
