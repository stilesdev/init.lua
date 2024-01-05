return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {'<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = 'Find Files'},
        {'<leader>gf', "<cmd>lua require('telescope.builtin').git_files()<cr>", desc = 'Git Files'},
        {'<leader>fs', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<cr>", desc = 'File Search'},
    },
    opts = function()
        local actions = require('telescope.actions')

        return {
            defaults = {
                mappings = {
                    i = {
                        ['<esc>'] = actions.close
                    },
                },
            },
        }
    end
}
