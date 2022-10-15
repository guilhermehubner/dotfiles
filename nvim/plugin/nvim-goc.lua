local goc = require 'nvim-goc'
goc.setup({verticalSplit = true})

vim.api.nvim_set_hl(0, 'GocNormal', {link = 'Comment'})
vim.api.nvim_set_hl(0, 'GocCovered', {link = 'DraculaGreen'})
vim.api.nvim_set_hl(0, 'GocUncovered', {link = 'DraculaRed'})

vim.cmd('command! -nargs=* -bang GoCoverage lua require("nvim-goc").Coverage()')
vim.cmd('command! -nargs=* -bang GoCoverageClear lua require("nvim-goc").ClearCoverage()')
vim.cmd('command! -nargs=* -bang GoAlternate lua require("nvim-goc").Alternate(true)')
