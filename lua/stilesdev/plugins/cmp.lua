return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            run = "make install_jsregexp",
            config = function()
                require('luasnip.loaders.from_snipmate').lazy_load()
            end,
        },
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {
            -- properly configure luals for editing neovim configuration
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {},
        },
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
                { name = 'lazydev' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
            },
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            preselect = cmp.PreselectMode.None,
            formatting = lsp.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })
    end,
}
