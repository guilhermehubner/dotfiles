"*****************************************************************************
"" Plug install packages
"*****************************************************************************

" PluginManager ( https://github.com/junegunn/vim-plug )
call plug#begin('~/.config/nvim/plugged')

" Fuzzy search (ctrl p)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" General linting and fixers
Plug 'w0rp/ale'

" Python
Plug 'davidhalter/jedi-vim'

" GO
Plug 'fatih/vim-go'

" Autocomplete
Plug 'Valloric/YouCompleteMe'

" UI plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'guilhermehubner/dracula-vim', { 'as': 'dracula' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Highlights Syntax
Plug 'sheerun/vim-polyglot'

" LSP (Language Server Protocol)
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

"*****************************************************************************
"" UI configurations
"*****************************************************************************

" Color
colorscheme dracula_bold
hi Comment ctermfg=39
set t_Co=256

highlight clear SignColumn     " SignColumn should match background
highlight clear LineNr         " Current line number row will have same background color in relative mode
highlight LineNr ctermfg=240
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE ctermfg=240
highlight MatchParen cterm=bold ctermbg=none ctermfg=208

" Mark column limit for languages
autocmd BufRead,BufNewFile *.go let &colorcolumn=join(range(101,2000),",")
autocmd BufRead,BufNewFile *.py let &colorcolumn=join(range(81,2000),",")


" No spellcheck
set nospell

" No folding
set nofoldenable

"No hidden
set nohidden

" Auto reload if file saved externally
set autoread

" Automatically highlight matching braces/brackets/etc.
set showmatch
set matchtime=2 " match only 2 times

" General improvements
set lazyredraw
set laststatus=2
set noshowmode
set number

" Split configurations
set splitright
set splitbelow
set inccommand=nosplit

" Connect clipboard from OS to VIM clipboard
set clipboard=unnamedplus

" Allow mouse usage
set mouse=a

" Remove banner from netew (Folder tree)
let g:netrw_banner=0

" Syntax for file extensions
autocmd BufRead,BufNewFile *.qtpl set filetype=html

"*****************************************************************************
"" Vim configurations (overwritting some defaults)
"*****************************************************************************

" No backup (annoying swp files)
set noswapfile
set nobackup
set nowb

" Setting history and undo size to a higher value
set history=1000
set undolevels=1000

" Remove useless spaces at EOF on save
autocmd BufWritePre * %s/\s\+$//e

" Don't show useless files in netrw
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'

" Don't yank on paste
xnoremap <expr> p 'pgv"'.v:register.'y'
xnoremap <expr> P 'Pgv"'.v:register.'y'

" Avoid long line issues
map k gk
map j gj

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Vim and nvim compliance
set viminfo='10,\"100,:20,%,n~/.nviminfo

" Set default tab to 4 spaces
set sts=4 ts=4 sw=4 expandtab smarttab ai smartindent

" Padding on j/k at least 5 lines from the screen end
set so=5

"*****************************************************************************
"" Mappings
"*****************************************************************************

" Close quickfix
nnoremap <leader><space> :cclose<CR> :lclose<CR>

" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

 " Split
nnoremap <leader>v :vsp<CR>
inoremap <leader>v <Esc>:vsp<CR>
nnoremap <leader>h :sp<CR>
inoremap <leader>h <Esc>:sp<CR>
nnoremap <leader>wh :windo wincmd K<CR>
nnoremap <leader>wv :windo wincmd H<CR>

" Tabs
nnoremap <leader>t :tabe<CR>
inoremap <leader>t <Esc>:tabe<CR>

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Search
nnoremap <silent> <leader>f :BLines<CR>

" Avoiding annoying mistakes when :w, :wq, :q, etc...
cab qw wq
cab Qw wq
cab qW wq
cab QW wq
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

"*****************************************************************************
"" Plugins configurations
"*****************************************************************************

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
set completeopt-=preview

let g:ycm_language_server =
    \[
        \ {
        \   'name': 'javascript-typescript',
        \   'cmdline': ['javascript-typescript-stdio'],
        \   'filetypes': ['javascript', 'typescript', 'typescriptreact']
        \ },
        \ {
        \   'name': 'go',
        \   'cmdline': ['gopls'],
        \   'filetypes': ['go']
        \ },
    \]

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

    " Navigate between errors
    nmap <silent> <C-j> <Plug>(ale_next_wrap)

    " Customize lints for languages
    let g:ale_linters = {
    \  'go': ['gopls', 'golangci-lint'],
    \  'python': ['flake8', 'pylint'],
    \  'typescriptreact': ['tsserver'],
    \  'typescript': ['tsserver'],
    \  'javascript': ['eslint'],
    \}

    " Customize fixers for languages
    let g:ale_fixers = {
    \ 'javascript': ['prettier'],
    \ 'javascript.jsx': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'typescriptreact': ['prettier'],
    \ 'html': ['prettier'],
    \ 'css': ['prettier'],
    \ 'scss': ['prettier'],
    \ 'sass': ['prettier'],
    \ 'json': ['prettier'],
    \ 'md': ['prettier'],
    \ 'graphql': ['prettier'],
    \ 'python': ['yapf', 'autopep8'],
    \}

" ===== vim-go =====
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'godef'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1


au FileType go nmap <C-]> <Plug>(go-def)
au FileType go nmap <Leader>rn <Plug>(go-rename)
au FileType go nmap <Leader>dh <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gr <Plug>(go-referrers)
au FileType go nmap <C-k> <Plug>(go-info)

" work around to coverage works with github.com/agiledragon/gomonkey/
cab GoCoverage GoCoverage -gcflags=all=-l

" ====== jedi-vim ======
let g:jedi#goto_command = "<C-]>"
let g:jedi#usages_command = "<leader>gr"
let g:jedi#rename_command = "<leader>rn"
let g:jedi#completions_enabled = 0

" ===== LanguageClient-neovim =====
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescriptreact': ['javascript-typescript-stdio'],
\ }

" javascript
au FileType javascript,javascript.jsx,typescript,typescriptreact nnoremap <C-k> :call LanguageClient#textDocument_hover()<CR>
au FileType javascript,javascript.jsx,typescript,typescriptreact nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>
au FileType javascript,javascript.jsx,typescript,typescriptreact nmap <Leader>rn :call LanguageClient#textDocument_rename()<CR>

" ===== vim-airline =====
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme = 'term'
let g:airline_section_b='%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'
let g:airline_symbols.dirty=''
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" ===== fzf =====
let $FZF_DEFAULT_COMMAND = 'ag -l -g "" --ignore-dir=vendor/'
nnoremap <silent> <C-p> :FZF<CR>

" vim-gitgutter
set updatetime=250
