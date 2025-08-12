-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indent with 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- disable line wrapping
vim.opt.wrap = false

-- no swap or backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- keep long undo history for use by undotree plugin
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- highlight text while typing search term, but not after search is submitted
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- make search case-sensitive, but only when search term contains an uppercase character
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep 8 lines visible at the top and bottom of the window while scrolling through files
vim.opt.scrolloff = 8

-- always show sign column instead of hiding it when there are no signs to display
vim.opt.signcolumn = "yes"

-- TODO: figure out what this does and whether I want it
--vim.opt.isfname:append("@-@")

-- how long vim should wait for cursor to stop moving before firing CursorHold event
vim.opt.updatetime = 500 -- default 4000, increase if performance suffers

-- when a file has been detected to have been changed outside of vim and not changed inside vim, automatically read it again
vim.opt.autoread = true

-- automatic clipboard tool detection doesn't work when in local tmux session -> ssh to remote machine -> run nvim on remote machine without remote tmux session
-- osc52 still works in this situation even though it isn't automatically detected by neovim
-- other situations work with automatic detection:
-- - local terminal with or without tmux session (on wayland): detects wl-copy
-- - local terminal without tmux -> ssh to remote machine without tmux: detects osc52
-- - local terminal without tmux -> ssh to remote machine -> remote tmux session: detects tmux
-- - local tmux session -> ssh to remote machine -> remote tmux session: detects tmux
if vim.env.SSH_TTY ~= nil and vim.env.TMUX == nil then
    vim.g.clipboard = 'osc52'
end

-- highlight on yank
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function ()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 500 })
    end,
})

-- diagnostics appearance
vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = false,
})
