" PluginManager ( https://github.com/junegunn/vim-plug )
call plug#begin('~/.config/nvim/plugged')

" Fuzzy search (ctrl p)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" General linting and fixers
Plug 'w0rp/ale'

" GO
Plug 'fatih/vim-go'

" PHP
Plug 'phpactor/phpactor', { 'do': 'composer install' }

" Autocomplete
Plug 'Valloric/YouCompleteMe'

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
Plug 'sheerun/vim-polyglot'

" Breakpoint support
Plug 'puremourning/vimspector'

" Fold yaml
Plug 'pedrohdz/vim-yaml-folds'

call plug#end()
