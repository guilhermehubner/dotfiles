-- Set the space as leader key
vim.keymap.set('n', '<space>', '<nop>', {})
vim.keymap.set('', '<space>', '<leader>', {})

-- Split
vim.keymap.set('n', '<leader>v', ':vsp<CR>', {})
vim.keymap.set('i', '<leader>v', '<Esc>:vsp<CR>', {})
vim.keymap.set('n', '<leader>h', ':sp<CR>', {})
vim.keymap.set('i', '<leader>h', '<Esc>:sp<CR>', {})
vim.keymap.set('n', '<leader>wh', ':windo wincmd K<CR>', {})
vim.keymap.set('n', '<leader>wv', ':windo wincmd H<CR>', {})

vim.keymap.set('n', '<Up>', ':resize +2<CR>', {})
vim.keymap.set('n', '<Down>', ':resize -2<CR>', {})
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', {})
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', {})

-- Expand splits
vim.keymap.set('n', '<Leader>eh', '<C-w>_', {})
vim.keymap.set('n', '<Leader>ev', '<C-w>\\|', {})
vim.keymap.set('n', '<Leader>ef', '<C-w>_<C-w>\\|', {})

-- Don't yank on paste
vim.keymap.set('x', 'p', '\'pgv"\'.v:register."y"', {expr = true})
vim.keymap.set('x', 'P', '\'Pgv"\'.v:register."y"', {expr = true})

-- Avoid long line issues
vim.keymap.set('', 'k', 'gk', {})
vim.keymap.set('', 'j', 'gj', {})

-- Maintain visual mode after shifting > and <
vim.keymap.set('v', '<', '<gv', {})
vim.keymap.set('v', '>', '>gv', {})

-- Close quickfix
vim.keymap.set('n', '<leader><space>', ':cclose<CR> :lclose<CR>', {})

-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {})
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {})
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {})

-- Tabs
vim.keymap.set('n', '<C-h>', ':tabprevious<CR>', {silent = true})
vim.keymap.set('n', '<C-l>', ':tabnext<CR>', {silent = true})

-- No need for ex mode
vim.keymap.set('n', 'Q', '<nop>', {})

-- Avoiding annoying mistakes when :w, :wq, :q, etc...
vim.cmd('cab qw wq')
vim.cmd('cab Qw wq')
vim.cmd('cab qW wq')
vim.cmd('cab QW wq')
vim.cmd('cab W  w')
vim.cmd('cab Wq wq')
vim.cmd('cab wQ wq')
vim.cmd('cab WQ wq')
vim.cmd('cab Q  q')
