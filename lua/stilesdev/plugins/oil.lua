return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
    },
    keys = {
        { '<leader>fv', '<cmd>Oil<cr>', desc = "Open File Browser" },
    },
}
