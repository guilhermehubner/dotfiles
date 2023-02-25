-- PluginManager ( https://github.com/wbthomason/packer.nvim )
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Snippet
    use {'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip'}

    -- LSP
    use {
        'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp-signature-help'
    }

    -- Navigation / Finder
    use {'nvim-telescope/telescope.nvim', tag = '0.1.1'}

    -- Dependency for some plugins
    use 'nvim-lua/plenary.nvim'

    -- Go Coverage
    use {'rafaelsq/nvim-goc.lua', after = 'dracula', {as = 'nvim-goc'}}

    -- UI plugins
    use {'guilhermehubner/dracula-vim', {as = 'dracula'}}

    -- Highlight search only when searching
    use 'romainl/vim-cool'

    -- Git
    use {'airblade/vim-gitgutter', 'tpope/vim-fugitive'}

    -- Highlights Syntax
    use 'nvim-treesitter/nvim-treesitter'

    -- Breakpoint support
    use 'puremourning/vimspector'

    -- Fold yaml
    use 'pedrohdz/vim-yaml-folds'

    -- Status Line
    use 'nvim-lualine/lualine.nvim'
end)
