-- Remove banner from netew (Folder tree)
vim.g.netrw_banner = 0

-- Don't show useless files in netrw
vim.g.netrw_list_hide = '.*\\.swp$,.*\\.pyc'

-- Allow netrw to remove non-empty local directories

vim.g.netrw_localrmdir = 'rm -r'
