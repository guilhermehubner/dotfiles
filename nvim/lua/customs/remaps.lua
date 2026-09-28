-- Set the space as leader key
vim.api.nvim_set_keymap('n', '<space>', '<nop>', {})
vim.api.nvim_set_keymap('', '<space>', '<leader>', {})

-- Split
vim.api.nvim_set_keymap('n', '<leader>v', ':vsp<CR>', {})
vim.api.nvim_set_keymap('i', '<leader>v', '<Esc>:vsp<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>h', ':sp<CR>', {})
vim.api.nvim_set_keymap('i', '<leader>h', '<Esc>:sp<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>wh', ':windo wincmd K<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>wv', ':windo wincmd H<CR>', {})

vim.api.nvim_set_keymap('n', '<Up>', ':resize +2<CR>', {})
vim.api.nvim_set_keymap('n', '<Down>', ':resize -2<CR>', {})
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize +2<CR>', {})
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize -2<CR>', {})

-- Expand splits
vim.api.nvim_set_keymap('n', '<Leader>eh', '<C-w>_', {})
vim.api.nvim_set_keymap('n', '<Leader>ev', '<C-w>\\|', {})
vim.api.nvim_set_keymap('n', '<Leader>ef', '<C-w>_<C-w>\\|', {})

-- Don't yank on paste
vim.api.nvim_set_keymap('x', 'p', '\'pgv"\'.v:register."y"', { expr = true })
vim.api.nvim_set_keymap('x', 'P', '\'Pgv"\'.v:register."y"', { expr = true })

-- Avoid long line issues
vim.api.nvim_set_keymap('', 'k', 'gk', {})
vim.api.nvim_set_keymap('', 'j', 'gj', {})

-- Maintain visual mode after shifting > and <
vim.api.nvim_set_keymap('v', '<', '<gv', {})
vim.api.nvim_set_keymap('v', '>', '>gv', {})

-- Close quickfix
vim.api.nvim_set_keymap('n', '<leader><space>', '<cmd>cclose<bar>lclose<CR>', {})

-- Move lines up and down
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', {})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', {})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {})
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', {})
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', {})

-- Tabs
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', { silent = true })

-- No need for ex mode
vim.api.nvim_set_keymap('n', 'Q', '<nop>', {})

-- Avoiding annoying mistakes when :w, :wq, :q, etc...
local function cmd_typo(typo, fix)
    vim.keymap.set('ca', typo, function()
        return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == typo) and fix or typo
    end, { expr = true })
end

cmd_typo('qw', 'wq')
cmd_typo('Qw', 'wq')
cmd_typo('qW', 'wq')
cmd_typo('QW', 'wq')
cmd_typo('W', 'w')
cmd_typo('Wq', 'wq')
cmd_typo('wQ', 'wq')
cmd_typo('WQ', 'wq')
cmd_typo('Q', 'q')

-- Quickfix
vim.api.nvim_set_keymap('n', '<leader>qo', ':copen<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>qc', ':cclose<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>qn', ':cn<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>qp', ':cp<CR>', {})
