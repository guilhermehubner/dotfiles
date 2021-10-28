local goc = require 'nvim-goc'
goc.setup({verticalSplit = true})

vim.highlight.link('GocNormal', 'Comment', true)
vim.highlight.link('GocCovered', 'DraculaGreen', true)
vim.highlight.link('GocUncovered', 'DraculaRed', true)

vim.cmd('command! -nargs=* -bang GoCoverage lua require("nvim-goc").Coverage()')
vim.cmd('command! -nargs=* -bang GoCoverageClear lua require("nvim-goc").ClearCoverage()')
vim.cmd('command! -nargs=* -bang GoAlternate lua require("nvim-goc").Alternate(true)')
