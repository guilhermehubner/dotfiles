local map = vim.keymap.set

vim.g.mapleader = ' '

-- Space on its own still does nothing, instead of moving the cursor one character right.
map({ 'n', 'x' }, '<space>', '<nop>')

-- Split
map('n', '<leader>v', '<cmd>vsp<CR>', { desc = 'Split window vertically' })
map('n', '<leader>h', '<cmd>sp<CR>', { desc = 'Split window horizontally' })
map('n', '<leader>wh', '<cmd>windo wincmd K<CR>', { desc = 'Stack all windows horizontally' })
map('n', '<leader>wv', '<cmd>windo wincmd H<CR>', { desc = 'Arrange all windows side by side' })

map('n', '<Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<Left>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })
map('n', '<Right>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })

-- Expand splits
-- The old rhs '<C-w>\|' was stored literally with the backslash, so it sent <C-w>\ followed by |
-- instead of <C-w>|, and the width part never ran. The API doesn't need | escaped.
map('n', '<leader>eh', '<C-w>_', { desc = 'Maximize window height' })
map('n', '<leader>ev', '<C-w>|', { desc = 'Maximize window width' })
map('n', '<leader>ef', '<C-w>_<C-w>|', { desc = 'Maximize window' })

-- Don't yank on paste
map('x', 'p', '\'pgv"\'.v:register."y"', { expr = true, desc = 'Paste without yanking selection' })
map('x', 'P', '\'Pgv"\'.v:register."y"', { expr = true, desc = 'Paste without yanking selection' })

-- Avoid long line issues
map({ 'n', 'x', 'o' }, 'k', 'gk', { desc = 'Move up by display line' })
map({ 'n', 'x', 'o' }, 'j', 'gj', { desc = 'Move down by display line' })

-- Maintain visual mode after shifting > and <
map('x', '<', '<gv', { desc = 'Indent left and keep selection' })
map('x', '>', '>gv', { desc = 'Indent right and keep selection' })

-- Close quickfix
map('n', '<leader><space>', '<cmd>cclose<bar>lclose<CR>', { desc = 'Close quickfix and loclist' })

-- Move lines up and down
map('n', '<A-j>', ':m .+1<CR>==', { silent = true, desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { silent = true, desc = 'Move line up' })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { silent = true, desc = 'Move line down' })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { silent = true, desc = 'Move line up' })
map('x', '<A-j>', ':m \'>+1<CR>gv=gv', { silent = true, desc = 'Move selection down' })
map('x', '<A-k>', ':m \'<-2<CR>gv=gv', { silent = true, desc = 'Move selection up' })

-- Tabs
map('n', '<C-h>', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
map('n', '<C-l>', '<cmd>tabnext<CR>', { desc = 'Next tab' })

-- No need for ex mode
map('n', 'Q', '<nop>', { desc = 'Disabled (Ex mode)' })

-- Avoiding annoying mistakes when :w, :wq, :q, etc...
local function cmd_typo(typo, fix)
    map('ca', typo, function()
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
map('n', '<leader>qo', '<cmd>copen<CR>', { desc = 'Open quickfix list' })
map('n', '<leader>qc', '<cmd>cclose<CR>', { desc = 'Close quickfix list' })
map('n', '<leader>qn', '<cmd>cn<CR>', { desc = 'Next quickfix item' })
map('n', '<leader>qp', '<cmd>cp<CR>', { desc = 'Previous quickfix item' })
