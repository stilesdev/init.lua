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
                dap = true,
                dap_ui = true,
                gitsigns = true,
                harpoon = true,
                leap = true,
                mason = true,
                treesitter = true,
            },
            custom_highlights = function (colors)
                return {
                    -- some colors changed as a result of vue_ls adding semantic highlighting support - change them back here
                    ['@function.builtin'] = { link = 'Function' },
                    ['@variable.builtin'] = { link = '@type.builtin' },
                    ['@lsp.type.component.vue'] = { fg = colors.pink },
                }
            end,
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
