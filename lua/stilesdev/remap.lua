vim.g.mapleader = ' '

-- open Netrw
--vim.keymap.set('n', '<leader>fv', vim.cmd.Ex)

-- move highlighted lines up and down in visual mode with shift J and K
-- indents highlighted lines properly when moving them inside of another block
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keep cursor in current position when using J to append previous line to current line separated by space
vim.keymap.set('n', 'J', 'mzJ`z')

-- keep cursor in middle of screen when moving up and down half pages with C-u and C-d
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- keep cursor in middle of screen when searching with /
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- yank/delete/put using system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"+d')
vim.keymap.set('v', '<leader>d', '"+d')

vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')

-- make current file executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod u+x %<CR>')
