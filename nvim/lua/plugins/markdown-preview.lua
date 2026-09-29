return {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
        require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
        vim.fn['mkdp#util#install']()
    end,
    init = function()
        vim.g.mkdp_filetypes = { 'markdown' }
    end,
    keys = {
        {
            '<leader>mp',
            '<cmd>MarkdownPreviewToggle<CR>',
            ft = 'markdown',
            desc = 'Markdown: Toggle preview',
        },
    },
}
