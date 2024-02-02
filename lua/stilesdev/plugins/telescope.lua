return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {'<leader>ff', function() require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' } }) end, desc = 'Find Files'},
        {'<leader>gf', function() require('telescope.builtin').git_files() end, desc = 'Git Files'},
        {'<leader>fs', function() require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') }) end, desc = 'File Search'},
        {'<leader>fa', function() require('telescope.builtin').live_grep() end, desc = 'Live Grep'},
        {'<leader>fw', function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) end, desc = 'File Search (Current Word)'},
        {'<leader>fW', function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cWORD>') }) end, desc = 'File Search (Current WORD)'}
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
