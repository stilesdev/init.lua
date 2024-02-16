return {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
        'catppuccin',
    },
    event = {'BufReadPre', 'BufNewFile'},
    config = function ()
        local hooks = require('ibl.hooks')
        local colors = require('catppuccin.palettes').get_palette('mocha')

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
            vim.api.nvim_set_hl(0, 'CurrentScope', { fg = colors.surface2 })
        end)

        require('ibl').setup({
            indent = {
                char = '▏',
            },
            scope = {
                show_start = false,
                show_end = false,
                highlight = 'CurrentScope',
            },
        })
    end
}
