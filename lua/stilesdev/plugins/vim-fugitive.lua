return {
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
        {'<leader>gs', "<cmd>Git<cr>", desc = "Git Status"},
        {'<leader>gc', "<cmd>Git commit<cr>", desc = "Git Commit"},
        {'<leader>gp', "<cmd>Git push<cr>", desc = "Git Push"},
        {'<leader>gu', "<cmd>Git pull<cr>", desc = "Git Pull"}, -- 'u' = update
    },
}
