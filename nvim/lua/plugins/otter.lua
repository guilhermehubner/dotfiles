return {
    'jmbuhr/otter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'go' },
    config = function()
        require('otter').setup()

        -- Mirror SQL injected in Go strings (queries/go/injections.scm) into hidden buffers,
        -- so sqls can provide completion and diagnostics inside them
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('OtterSql', { clear = true }),
            pattern = 'go',
            callback = function()
                require('otter').activate({ 'sql' })
            end,
        })

        if vim.bo.filetype == 'go' then
            require('otter').activate({ 'sql' })
        end
    end,
}
