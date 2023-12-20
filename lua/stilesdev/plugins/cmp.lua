return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {'L3MON4D3/LuaSnip'},
    },
    config = function()
        -- Configure autocompletion settings
        local lsp = require('lsp-zero')
        lsp.extend_cmp()

        -- And you can configure cmp even more if you want to
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_action = lsp.cmp_action()

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
            },
            formatting = lsp.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
        })
    end,
}
