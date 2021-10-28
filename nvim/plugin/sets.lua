-- increase max memory to show syntax highlighting for large files
vim.opt.maxmempattern = 20000

-- No spellcheck
vim.opt.spell = false

-- No folding
vim.opt.foldenable = false

-- No hidden
vim.opt.hidden = false

-- Auto reload if file saved externally
vim.opt.autoread = true

-- Automatically highlight matching braces/brackets/etc.
vim.opt.showmatch = true
vim.opt.matchtime = 2 -- match only 2 times

-- General improvements
vim.opt.lazyredraw = true
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.number = true

-- Split configurations
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'nosplit'

-- Connect clipboard from OS to VIM clipboard
vim.opt.clipboard = 'unnamedplus'

-- Allow mouse usage
vim.opt.mouse = 'a'

-- No backup (annoying swp files)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Setting history and undo size to a higher value
vim.opt.history = 1000
vim.opt.undolevels = 1000

-- Set default tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Padding on j/k at least 5 lines from the screen end
vim.opt.scrolloff = 5
