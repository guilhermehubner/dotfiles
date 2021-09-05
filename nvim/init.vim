" PluginManager ( https://github.com/junegunn/vim-plug )
call plug#begin('~/.config/nvim/plugged')

" Fuzzy search (ctrl p)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'gfanto/fzf-lsp.nvim'

" Go Coverage
Plug 'rafaelsq/nvim-goc.lua'

" UI plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'guilhermehubner/dracula-vim', { 'as': 'dracula' }

" Highlight search only when searching
Plug 'romainl/vim-cool'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Highlights Syntax
Plug 'nvim-treesitter/nvim-treesitter'

" Breakpoint support
Plug 'puremourning/vimspector'

" Fold yaml
Plug 'pedrohdz/vim-yaml-folds'

call plug#end()
