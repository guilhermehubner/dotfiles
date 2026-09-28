-- Set the space as leader key
vim.api.nvim_set_keymap('n', '<space>', '<nop>', {})
vim.api.nvim_set_keymap('', '<space>', '<leader>', { desc = 'Leader key' })

-- Split
vim.api.nvim_set_keymap('n', '<leader>v', ':vsp<CR>', { desc = 'Split window vertically' })
vim.api.nvim_set_keymap('i', '<leader>v', '<Esc>:vsp<CR>', { desc = 'Split window vertically' })
vim.api.nvim_set_keymap('n', '<leader>h', ':sp<CR>', { desc = 'Split window horizontally' })
vim.api.nvim_set_keymap('i', '<leader>h', '<Esc>:sp<CR>', { desc = 'Split window horizontally' })
vim.api.nvim_set_keymap(
    'n',
    '<leader>wh',
    ':windo wincmd K<CR>',
    { desc = 'Stack all windows horizontally' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>wv',
    ':windo wincmd H<CR>',
    { desc = 'Arrange all windows side by side' }
)

vim.api.nvim_set_keymap('n', '<Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.api.nvim_set_keymap('n', '<Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.api.nvim_set_keymap(
    'n',
    '<Left>',
    ':vertical resize +2<CR>',
    { desc = 'Increase window width' }
)
vim.api.nvim_set_keymap(
    'n',
    '<Right>',
    ':vertical resize -2<CR>',
    { desc = 'Decrease window width' }
)

-- Expand splits
vim.api.nvim_set_keymap('n', '<Leader>eh', '<C-w>_', { desc = 'Maximize window height' })
vim.api.nvim_set_keymap('n', '<Leader>ev', '<C-w>\\|', { desc = 'Maximize window width' })
vim.api.nvim_set_keymap('n', '<Leader>ef', '<C-w>_<C-w>\\|', { desc = 'Maximize window' })

-- Don't yank on paste
vim.api.nvim_set_keymap(
    'x',
    'p',
    '\'pgv"\'.v:register."y"',
    { expr = true, desc = 'Paste over selection without yanking it' }
)
vim.api.nvim_set_keymap(
    'x',
    'P',
    '\'Pgv"\'.v:register."y"',
    { expr = true, desc = 'Paste over selection without yanking it' }
)

-- Avoid long line issues
vim.api.nvim_set_keymap('', 'k', 'gk', { desc = 'Move up by display line' })
vim.api.nvim_set_keymap('', 'j', 'gj', { desc = 'Move down by display line' })

-- Maintain visual mode after shifting > and <
vim.api.nvim_set_keymap('v', '<', '<gv', { desc = 'Indent left and keep selection' })
vim.api.nvim_set_keymap('v', '>', '>gv', { desc = 'Indent right and keep selection' })

-- Close quickfix
vim.api.nvim_set_keymap(
    'n',
    '<leader><space>',
    '<cmd>cclose<bar>lclose<CR>',
    { desc = 'Close quickfix and location lists' }
)

-- Move lines up and down
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down' })
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move selection down' })
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move selection up' })

-- Tabs
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', { silent = true, desc = 'Previous tab' })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', { silent = true, desc = 'Next tab' })

-- No need for ex mode
vim.api.nvim_set_keymap('n', 'Q', '<nop>', { desc = 'Disabled (Ex mode)' })

-- Avoiding annoying mistakes when :w, :wq, :q, etc...
local function cmd_typo(typo, fix)
    vim.keymap.set('ca', typo, function()
        return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == typo) and fix or typo
    end, { expr = true, desc = 'Fix typo :' .. typo .. ' -> :' .. fix })
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
vim.api.nvim_set_keymap('n', '<leader>qo', ':copen<CR>', { desc = 'Open quickfix list' })
vim.api.nvim_set_keymap('n', '<leader>qc', ':cclose<CR>', { desc = 'Close quickfix list' })
vim.api.nvim_set_keymap('n', '<leader>qn', ':cn<CR>', { desc = 'Next quickfix item' })
vim.api.nvim_set_keymap('n', '<leader>qp', ':cp<CR>', { desc = 'Previous quickfix item' })
