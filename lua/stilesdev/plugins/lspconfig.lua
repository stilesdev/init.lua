return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {
            -- properly configure luals for editing neovim configuration
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {},
        },
        {'hrsh7th/cmp-nvim-lsp'},
        {'habamax/vim-godot'},
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = \'rounded\'})<cr>', {buffer = event.buf, desc = 'Hover documentation'})
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {buffer = event.buf, desc = 'Go to definition'})
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {buffer = event.buf, desc = 'Go to declaration'})
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {buffer = event.buf, desc = 'Go to implementation'})
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {buffer = event.buf, desc = 'Go to type definition'})
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {buffer = event.buf, desc = 'Go to reference'})
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', {buffer = event.buf, desc = 'Rename symbol'})
                vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {buffer = event.buf, desc = 'Format file'})
                vim.keymap.set('x', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {buffer = event.buf, desc = 'Format selection'})
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {buffer = event.buf, desc = 'Execute code action'})

                -- use LspAttach event instead of on_attach functions in vim.lsp.config below, since that would overwrite any on_attach function defined by lspconfig
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end

                if client.name == 'eslint' then
                    -- configure eslint to format on save
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = event.buf,
                        command = 'LspEslintFixAll', -- defined by lspconfig in eslint on_attach function
                    })

                    -- allow eslint to respond to lsp formatting requests
                    client.server_capabilities.documentFormattingProvider = true
                end
            end,
        })

        -- gdscript lsp support comes in from habamax/vim-godot (not mason), and only mason-installed lsps get enabled automatically
        vim.lsp.enable('gdscript')

        -- hybridMode may cause highlighting issues in the template scope when ts_ls attaches to vue files
        local use_volar_hybrid_mode = false

        -- load settings for work (stored in separate private repo)
        local has_work_lsp_settings, work_lsp_settings = pcall(require, "work-lsp")

        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    -- Disable telemetry
                    telemetry = {enable = false},
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'}
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            -- Make the server aware of Neovim runtime files
                            vim.fn.expand('$VIMRUNTIME/lua'),
                            vim.fn.stdpath('config') .. '/lua'
                        },
                    },
                },
            },
        })

        vim.lsp.config('lemminx', {
            settings = {
                xml = {
                    server = {
                        workDir = '~/.cache/lemminx',
                    },
                },
            },
            on_init = function(client, bufnr)
                -- allow lemminx to respond to lsp formatting requests
                client.server_capabilities.documentFormattingProvider = true
                client.server_capabilities.documentFormattingRangeProvider = true
            end,
        })

        vim.lsp.config('intelephense', {
            init_options = {
                globalStoragePath = vim.fn.expand('$HOME/.local/share/nvim/intelephense'),
                licenceKey = vim.fn.expand('$HOME/.local/share/nvim/intelephense.key'), -- key as string, or absolute path to text file containing the key
            },
            on_init = function(client)
                if has_work_lsp_settings then
                    work_lsp_settings.intelephense_on_init(client)
                end

                client.server_capabilities.completionProvider.triggerCharacters = {
                    -- php
                    -- '$', '>', ':', '\\', '/', '\'', '"',
                    '$', ':', '\\', '/', '\'', '"',
                    --phpdoc
                    '*',
                    -- html/js
                    '.', '<'
                }

                return true
            end,
            settings = {
                intelephense = {
                    format = {
                        braces = 'k&r',
                    },
                },
            },
        })

        vim.lsp.config('stylelint_lsp', {
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

        vim.lsp.config('tailwindcss', {
            filetypes = {
                'css',
                'less',
                'scss',
                'vue',
            },
        })

        local ts_ls_filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json' }
        if use_volar_hybrid_mode then
            table.insert(ts_ls_filetypes, 'vue')
        end
        vim.lsp.config('ts_ls', {
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
                        languages = { 'vue' },
                    },
                },
            },
            filetypes = ts_ls_filetypes,
        })

        vim.lsp.config('vue_ls', {
            -- restrict Volar to only Vue/Nuxt projects
            root_markers = {
                'vue.config.js',
                'vue.config.ts',
                'nuxt.config.js',
                'nuxt.config.ts',
            },
            init_options = {
                vue = {
                    hybridMode = use_volar_hybrid_mode,
                },
            },
            settings = {
                css = {
                    lint = {
                        unknownAtRules = 'ignore',
                    },
                },
            },
            -- disable Volar LSP formatting
            on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
            end,
        })

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'eslint',        -- JS/TS Linting
                'gopls',         -- Go
                'intelephense',  -- PHP
                'jsonls',        -- JSON
                'lemminx',       -- XML
                'lua_ls',        -- LUA
                'stylelint_lsp', -- CSS Linting
                'tailwindcss',   -- Tailwind CSS
                'taplo',         -- TOML
                'ts_ls',         -- JS/TS
                'vue_ls',        -- Vue
            },
        })
    end,
}
