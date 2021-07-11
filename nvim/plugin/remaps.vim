" Split
nnoremap <leader>v :vsp<CR>
inoremap <leader>v <Esc>:vsp<CR>
nnoremap <leader>h :sp<CR>
inoremap <leader>h <Esc>:sp<CR>
nnoremap <leader>wh :windo wincmd K<CR>
nnoremap <leader>wv :windo wincmd H<CR>

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Expand splits
nmap <Leader>eh <C-w>_
nmap <Leader>ev <C-w>\|
nmap <Leader>ef <C-w>_<C-w>\|

" Don't yank on paste
xnoremap <expr> p 'pgv"'.v:register.'y'
xnoremap <expr> P 'Pgv"'.v:register.'y'

" Avoid long line issues
map k gk
map j gj

" Maintain visual mode after shifting > and <
vmap < <gv
vmap > >gv

" Close quickfix
nnoremap <leader><space> :cclose<CR> :lclose<CR>

" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Tabs
nnoremap <leader>t :tabe<CR>
inoremap <leader>t <Esc>:tabe<CR>

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" No need for ex mode
nnoremap Q <nop>

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
