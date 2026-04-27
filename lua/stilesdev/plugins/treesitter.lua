return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main', -- 'main' for nvim 0.12+, 'master' for 0.11 and below
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')
        ts.setup()

        -- always install base set of parsers
        ts.install({
            -- general
            "bash",
            "diff",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "json",
            "lua",
            "markdown",
            "toml",
            "xml",
            "yaml",

            -- config languages
            "caddy",
            "dockerfile",
            "hyprlang",
            "nginx",
            "ssh_config",

            -- go
            "go",
            "gomod",
            "gosum",
            "gotmpl",

            -- php
            "php",
            "sql",

            -- web
            "html",
            "css",
            "javascript",
            "typescript",
            "vue",
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '*' },
            callback = function(event)
                local filetype = event.match
                local lang = vim.treesitter.language.get_lang(filetype)
                if lang == nil then return end

                local is_installed, _ = vim.treesitter.language.add(lang)

                -- auto_install parsers if available
                if not is_installed then
                    local available_langs = ts.get_available()
                    local is_available = vim.tbl_contains(available_langs, lang)

                    if is_available then
                        vim.notify('Installing treesitter parser for ' .. lang, vim.log.levels.INFO)
                        ts.install({ lang }):wait(30 * 1000)
                    end
                end

                -- for performance, do not enable treesitter for xml files with large line count
                if lang == 'xml' and vim.api.nvim_buf_line_count(event.buf) > 50000 then return end

                -- enable treesitter highlights
                local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
                if not ok then return end

                -- only enable treesitter indents for specific languages
                if vim.tbl_contains({'php'}, lang) then
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end
        })
    end,
}
