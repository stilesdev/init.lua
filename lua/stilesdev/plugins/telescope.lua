return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {'<leader>pf', "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = 'Find Project Files'},
        {'<leader>gf', "<cmd>lua require('telescope.builtin').git_files()<cr>", desc = 'Find Git Files'},
        {'<leader>ps', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<cr>", desc = 'Search Project Files'},
    },
}
