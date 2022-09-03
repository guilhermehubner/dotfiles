vim.env.FZF_DEFAULT_COMMAND =
    'ag -l -g "" --ignore-dir=vendor/ --ignore-dir=mock/ --ignore-dir=mocks/'

vim.api.nvim_set_keymap('n', '<leader>f', ':BLines<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<CR>', {silent = true})

-- Ag command ignore vendor
vim.cmd [[
  augroup go_search
    autocmd!
    " Ag
    autocmd FileType go command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore vendor', <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
  augroup END
]]
