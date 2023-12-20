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

-- keep 8 lines visible at the top and bottom of the window while scrolling through files
vim.opt.scrolloff = 8

-- always show sign column instead of hiding it when there are no signs to display
vim.opt.signcolumn = "yes"

-- TODO: figure out what this does and whether I want it
--vim.opt.isfname:append("@-@")

-- how long vim should wait for cursor to stop moving before firing CursorHold event
vim.opt.updatetime = 500 -- default 4000, increase if performance suffers

