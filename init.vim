" Plugins
"  PluginManager
"   https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8', {'do': 'pip install flake8'}

" GO
Plug 'fatih/vim-go'

Plug 'Valloric/YouCompleteMe'

" JS
 Plug 'pangloss/vim-javascript'
 Plug 'ternjs/tern_for_vim', { 'do': 'yarn' }

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" TypeScript
Plug 'w0rp/ale'
Plug 'runoshun/tscompletejob'

 " React
 Plug 'mxw/vim-jsx'

" Others
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'guilhermehubner/dracula-vim', { 'as': 'dracula' }

" Git
Plug 'airblade/vim-gitgutter'

" Highlights Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

" UI Configuration {
colorscheme dracula_bold
hi Comment ctermfg=39

set nospell
set t_Co=256
set nofoldenable
set nohidden
set autoread " auto reload if file saved externally
highlight clear SignColumn     " SignColumn should match background
highlight clear LineNr         " Current line number row will have same background color in relative mode
highlight LineNr ctermfg=240
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE ctermfg=240
set showmatch                  " automatically highlight matching braces/brackets/etc.
set matchtime=2                " tens of a second to show matching parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=208
set lazyredraw
set laststatus=2
set noshowmode
set number
set clipboard=unnamedplus

set splitright
set splitbelow

set inccommand=nosplit

set mouse=a

" avoid long line issues
map k gk
map j gj

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

let g:netrw_banner=0

" close quickfix
nnoremap <leader><space> :cclose<CR> :lclose<CR>

" mark column limit for languages
autocmd BufRead,BufNewFile *.go let &colorcolumn=join(range(101,2000),",")
autocmd BufRead,BufNewFile *.py let &colorcolumn=join(range(81,2000),",")

" set history and undo size
set history=1000
set undolevels=1000
" }

" nobackup {
set noswapfile
set nobackup
set nowb
" }

" remove all spaces at EOF on save {
 autocmd BufWritePre * %s/\s\+$//e
" }

" Move lines {
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" }

 " Split {
nnoremap <leader>v :vsp<CR>
inoremap <leader>v <Esc>:vsp<CR>

nnoremap <leader>h :sp<CR>
inoremap <leader>h <Esc>:sp<CR>

nnoremap <leader>wh :windo wincmd K<CR>
nnoremap <leader>wv :windo wincmd H<CR>
" }

" Tabs {
nnoremap <leader>t :tabe<CR>
inoremap <leader>t <Esc>:tabe<CR>

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" }

" Search {
nnoremap <silent> <leader>f :BLines<CR>
" }

" avoid annoying things {
cab qw wq
cab Qw wq
cab qW wq
cab QW wq
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
let g:netrw_localrmdir='rm -r' " Allow netrw to remove non-empty local directories

" don't yank on paste
xnoremap <expr> p 'pgv"'.v:register.'y'
xnoremap <expr> P 'Pgv"'.v:register.'y'
" }

" vim-airline
let g:airline_theme = 'term'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_skip_empty_sections = 1
" }

"vim and nvim compliance
set viminfo='10,\"100,:20,%,n~/.nviminfo

" default tab to 4 spaces
set sts=4 ts=4 sw=4 expandtab smarttab ai smartindent

" padding on j/k
set so=5

" YouCompleteMe {
 let g:ycm_key_list_select_completion = ['<C-n>']
 let g:ycm_key_list_previous_completion = ['<C-p>']
 set completeopt-=preview
" }


" default C-n next, C-p prev; now tab & shift+tab {
    " fix conflict with tab below
    let g:UltiSnipsExpandTrigger = "<leader>j"

 inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
 inoremap <silent><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" }

" Git vim-gitgutter {
 set updatetime=250
" }

" FZF {
 let $FZF_DEFAULT_COMMAND = 'ag -l -g "" --ignore-dir=vendor/'
 nnoremap <silent> <C-p> :FZF<CR>
" }

" Syntax for file extensions
 autocmd BufRead,BufNewFile *.qtpl set filetype=html
" }

" ale {
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

    "navigate between errors
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)

    "customize lints for languages
    let g:ale_linters = {
    \    'go': [],
    \}
" }

" tscompletejob {
let g:tscompletejob_mappings_disable_default = 1

au Filetype typescript nmap <C-]> <Plug>(TsCompleteJobGotoDefinition)
au Filetype typescript nmap <C-k> <Plug>(TsCompleteJobQuickInfo)
au Filetype typescript nmap <Leader>= <Plug>(TsCompleteJobFormat)
au Filetype typescript nmap <Leader>gr <Plug>(TsCompleteJobReferences)
au Filetype typescript nmap <Leader>rn <Plug>(TsCompleteJobRename)
" }

" vim-go {
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
" }

" jedi-vim {
 let g:jedi#goto_command = "<C-]>"
 let g:jedi#usages_command = "<leader>gr"
 let g:jedi#rename_command = "<leader>rn"
" }

" vim-flake8 {
 autocmd BufWritePost *.py call Flake8()
 let g:flake8_show_in_gutter=1
 let g:flake8_show_in_file=1
" }

" tern_for_vim {
 au FileType javascript nmap <C-]> :TernDef<CR>
" }

" buffer {
 nnoremap <silent> <leader>b :Buffers<CR>
" }

" Prettier {
 let g:prettier#autoformat = 0
 autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
" }
