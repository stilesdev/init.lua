return {
    'tpope/vim-commentary',
    lazy = false,
    init = function ()
        -- force use of // comments in php
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { "php" },
            callback = function()
                vim.opt_local.commentstring = "// %s"
            end
        })
    end
}
