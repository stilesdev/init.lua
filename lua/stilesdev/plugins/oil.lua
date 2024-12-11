return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            -- disable keys interfering with harpoon in oil buffers
            ['<C-j>'] = false,
            ['<C-k>'] = false,
            ['<C-l>'] = false,
        },
    },
    keys = {
        { '<leader>fv', '<cmd>Oil<cr>', desc = "Open File Browser" },
    },
}
