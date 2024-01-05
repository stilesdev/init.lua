return {
    'lewis6991/gitsigns.nvim',
    opts = {
        on_attach = function()
            local gs = package.loaded.gitsigns

            vim.keymap.set('n', '<leader>gd', gs.preview_hunk_inline)
        end,
    },
}
