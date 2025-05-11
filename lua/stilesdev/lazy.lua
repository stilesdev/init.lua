local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable", -- latest stable release
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- ~/.config/nvim-work is stored under a different private dotfiles repo. Add it to runtimepath if it exists.
local work_dir = vim.fn.simplify(vim.fn.stdpath('config') .. '/../nvim-work')
local rtp_paths = {}
if vim.fn.isdirectory(work_dir) ~= 0 then
    rtp_paths = {work_dir}
end

require("lazy").setup({
    spec = {
        -- import your plugins
        { import = config_namespace .. '.plugins' },
    },
    performance = {
        rtp = {
            paths = rtp_paths, -- add any custom paths here that you want to include in the runtimepath
        },
    },
})
