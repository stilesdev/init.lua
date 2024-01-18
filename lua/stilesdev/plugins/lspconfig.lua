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
                'jsonls',        -- JSON
                'lua_ls',        -- LUA
                'stylelint_lsp', -- CSS Linting
                'tailwindcss',   -- Tailwind CSS
                'taplo',         -- TOML
                'tsserver',      -- JS/TS
                'volar',         -- Vue
            },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    -- Optional: configure lua language server for neovim
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            },
        })
    end,
}
