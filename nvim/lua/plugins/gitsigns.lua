return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'Git: ' .. desc })
            end

            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end, 'Next hunk')
            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end, 'Previous hunk')

            map('n', '<leader>ghs', gitsigns.stage_hunk, 'Stage/unstage hunk')
            map('x', '<leader>ghs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end, 'Stage/unstage selected lines')
            map('n', '<leader>ghu', gitsigns.reset_hunk, 'Undo hunk')
            map('n', '<leader>ghp', gitsigns.preview_hunk, 'Preview hunk')
            map('n', '<leader>gb', function()
                gitsigns.blame_line({ full = true })
            end, 'Blame current line')

            map({ 'o', 'x' }, 'ic', gitsigns.select_hunk, 'Select hunk')
        end,
    },
}
