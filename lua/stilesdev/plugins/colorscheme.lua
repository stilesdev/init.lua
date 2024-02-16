return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            dim_inactive = {
                enabled = true,
                shade = 'light',
                percentage = 0.10,
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                harpoon = true,
                leap = true,
                mason = true,
                treesitter = true,
            },
        })

        -- termguicolors required for this color scheme
        vim.opt.termguicolors = true

        vim.cmd.colorscheme 'catppuccin-mocha'

        -- re-enable transparency
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

        -- tweak border color for floating windows
        local palette = require('catppuccin.palettes').get_palette('mocha')
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = palette.lavender })
    end,
}
