local goc = require 'nvim-goc'
goc.setup({verticalSplit = true})

vim.cmd('command! -nargs=* -bang GoCoverage lua require("nvim-goc").Coverage()')
vim.cmd('command! -nargs=* -bang GoCoverageClear lua require("nvim-goc").ClearCoverage()')
vim.cmd('command! -nargs=* -bang GoAlternate lua require("nvim-goc").Alternate(true)')
