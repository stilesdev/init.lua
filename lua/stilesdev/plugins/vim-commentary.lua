return {
    'tpope/vim-commentary',
    event = {'BufReadPre', 'BufNewFile'},
    opt = {},
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
}
