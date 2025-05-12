return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'catppuccin/nvim',
    },
    config = function ()
        local dap = require('dap')
        local ui = require('dapui')

        ui.setup()

        require('nvim-dap-virtual-text').setup({
            commented = true,
        })

        local mason_registry = require('mason-registry')
        if mason_registry.has_package('php-debug-adapter') then
            local php_debug_adapter = mason_registry.get_package('php-debug-adapter')
            if php_debug_adapter:is_installed() then
                dap.adapters.php = {
                    type = 'executable',
                    -- Mason adds executables from installed packages to PATH, so no need to look up full path
                    command = vim.fn.exepath('php-debug-adapter'),
                }

                local pathMappings = {}

                -- load settings for work (stored in separate private repo)
                local has_work_dap_settings, work_dap_settings = pcall(require, 'work-dap')
                if has_work_dap_settings then
                    pathMappings = work_dap_settings.get_php_dap_path_mappings()
                end

                dap.configurations.php = {
                    {
                        type = 'php',
                        request = 'launch',
                        name = 'Listen for Xdebug',
                        port = 9003,
                        -- maxConnections = 1,
                        pathMappings = pathMappings,
                    }
                }
            end
        end

        -- customize gutter signs (and highlights?)
        -- :h dap-launch.json (section "SIGNS CONFIGURATION").
        vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='DapBreakpoint', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='●', texthl='DapBreakpointCondition', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = ''})
        vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = ''})

        local palette = require('catppuccin.palettes').get_palette('mocha')
        vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = palette.surface1 })

        vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>bc', dap.run_to_cursor)

        -- Eval var under cursor
        vim.keymap.set("n", "<space>?", function()
            ui.eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<F6>", dap.continue)
        vim.keymap.set("n", "<F7>", dap.step_into)
        vim.keymap.set("n", "<F8>", dap.step_over)
        vim.keymap.set("n", "<F9>", dap.step_out)
        vim.keymap.set("n", "<F10>", dap.close)
        vim.keymap.set("n", "<F11>", dap.restart)
        vim.keymap.set("n", "<F12>", ui.toggle)

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end
}
