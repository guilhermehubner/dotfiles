lua << EOF
local goc = require'nvim-goc'
goc.setup({verticalSplit = true})
EOF

hi! link GocNormal Comment
hi! link GocCovered DraculaGreen
hi! link GocUncovered DraculaRed

command! -nargs=* -bang GoCoverage lua require("nvim-goc").Coverage()
command! -nargs=* -bang GoCoverageClear lua require("nvim-goc").ClearCoverage()
command! -nargs=* -bang GoAlternate lua require("nvim-goc").Alternate(true)
