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
    },
    config = function()
        local cmp = require('cmp')
        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
        -- local cmp_action = lsp.cmp_action()

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'lazydev' },
                { name = 'path' },
                { name = 'luasnip' },
                {
                    name = 'nvim_lsp',
                    -- Filter vue_ls completion items for more relevant results - from https://github.com/vuejs/language-tools/discussions/4495
                    ---@param entry cmp.Entry
                    ---@param ctx cmp.Context
                    entry_filter = function(entry, ctx)
                        -- Check if the buffer type is 'vue'
                        if ctx.filetype ~= 'vue' then
                            return true
                        end

                        local cursor_before_line = ctx.cursor_before_line
                        -- For events
                        if cursor_before_line:sub(-1) == '@' then
                            return entry.completion_item.label:match('^@')
                            -- For props also exclude events with `:on-` prefix
                        elseif cursor_before_line:sub(-1) == ':' then
                            return entry.completion_item.label:match('^:') and
                                not entry.completion_item.label:match('^:on%-')
                        else
                            return true
                        end
                    end
                },
                { name = 'nvim_lua' },
            },
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            preselect = cmp.PreselectMode.None,
            formatting = {
                fields = {'abbr', 'menu', 'kind'},
                format = function(entry, item)
                    local n = entry.source.name
                    local label = ''

                    if n == 'nvim_lsp' then
                        label = '[LSP]'
                    elseif n == 'nvim_lua'  then
                        label = '[nvim]'
                    else
                        label = string.format('[%s]', n)
                    end

                    if item.menu ~= nil then
                        item.menu =  string.format('%s %s', label, item.menu)
                    else
                        item.menu = label
                    end

                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({select = false}), -- select = whether to select the first option if no option is selected during confirm
                ['<C-y>'] = cmp.mapping.confirm({select = false}),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
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
