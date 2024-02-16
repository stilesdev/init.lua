return {
    'lewis6991/gitsigns.nvim',
    event = {'BufReadPre', 'BufNewFile'},
    opts = {
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 0,
            virt_text_priority = 5000,
        },
        current_line_blame_formatter = '    <author> • <author_time:%Y-%m-%d> • <summary>',

        on_attach = function()
            local gs = package.loaded.gitsigns

            vim.keymap.set('n', '<leader>gd', gs.preview_hunk_inline)
        end,
    },
}
