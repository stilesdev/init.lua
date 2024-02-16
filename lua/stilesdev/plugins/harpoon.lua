return {
    'theprimeagen/harpoon',
    opts = {
        menu = {
            width = math.min(150, math.floor(vim.api.nvim_win_get_width(0) * 0.8)),
        }
    },
    keys = {
        { '<leader>a', function() require('harpoon.mark').add_file() end, desc = "Add current file to Harpoon jump list" },
        { '<C-e>', function() require('harpoon.ui').toggle_quick_menu() end, desc = "Toggle Harpoon jump list UI" },
        { '<C-j>', function() require('harpoon.ui').nav_file(1) end },
        { '<C-k>', function() require('harpoon.ui').nav_file(2) end },
        { '<C-l>', function() require('harpoon.ui').nav_file(3) end },
        { '<C-;>', function() require('harpoon.ui').nav_file(4) end },
    },
}
