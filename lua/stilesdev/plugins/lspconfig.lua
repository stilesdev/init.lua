return {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
        {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
        local lsp = require('lsp-zero')
        lsp.extend_lspconfig()

        lsp.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({buffer = bufnr})
        end)

        --lsp.set_sign_icons({
        --    error = '󱎘', --   󱎘 󰚌 󰐼
        --    warn = '',  --    
        --    hint = '',  --    󱕅
        --    info = '󰙎',  --   󰙎 󰑊
        --})

        vim.diagnostic.config({
            underline = true,
            virtual_text = true,
            signs = false,
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                'eslint',        -- JS/TS Linting
                'gopls',         -- Go
                'jsonls',        -- JSON
                'lemminx',       -- XML
                'lua_ls',        -- LUA
                'stylelint_lsp', -- CSS Linting
                'tailwindcss',   -- Tailwind CSS
                'taplo',         -- TOML
                'tsserver',      -- JS/TS
                'volar@2.0.6',   -- Vue
            },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    -- Optional: configure lua language server for neovim
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                eslint = function()
                    require('lspconfig').eslint.setup({
                        on_attach = function(client, bufnr)
                            -- configure eslint to format on save
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                command = 'EslintFixAll',
                            })

                            -- allow eslint to respond to lsp formatting requests
                            client.server_capabilities.documentFormattingProvider = true
                        end,
                    })
                end,
                lemminx = function ()
                    require('lspconfig').lemminx.setup({
                        on_attach = function(client, bufnr)
                            -- allow lemminx to respond to lsp formatting requests
                            client.server_capabilities.documentFormattingProvider = true
                            client.server_capabilities.documentFormattingRangeProvider = true
                        end,
                    })
                end,
                stylelint_lsp = function ()
                    require('lspconfig').stylelint_lsp.setup({
                        -- only lint appropriate files
                        filetypes = {
                            'css',
                            'less',
                            'scss',
                            'vue',
                        },
                        settings = {
                            stylelintplus = {
                                -- format on save
                                autoFixOnSave = true,
                                -- respond to lsp formatting requests
                                autoFixOnFormat = true,
                            }
                        }
                    })
                end,
                tsserver = function()
                    local vue_ls_path = require('mason-registry').get_package('vue-language-server'):get_install_path()

                    require('lspconfig').tsserver.setup({
                        init_options = {
                            plugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    -- location = vue_ls_path .. '/typescript-plugin', -- something shorter like this should work once vue-language-server v2.0.7+ is released
                                    location = vue_ls_path .. '/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin',
                                    languages = { 'vue' },
                                },
                            },
                        },
                        filetypes = {
                            'javascript',
                            'typescript',
                            'vue',
                            'json',
                        },
                    })
                end,
                volar = function()
                    require('lspconfig').volar.setup({
                        filetypes = { 'vue' },

                        -- disable Volar LSP formatting
                        on_init = function(client)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentFormattingRangeProvider = false
                        end,
                    })
                end,
            },
        })
    end,
}
