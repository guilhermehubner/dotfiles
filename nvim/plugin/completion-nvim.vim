lua << EOF
vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
vim.g.completion_sorting = "none"
vim.opt.shortmess = vim.opt.shortmess + 'c'
vim.api.nvim_set_keymap('i', '<c-space>', '<Plug>(completion_trigger)', {silent=true})
EOF
