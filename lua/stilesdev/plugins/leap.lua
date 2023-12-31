return {
    'ggandor/leap.nvim',
    dependencies = {
        'tpope/vim-repeat',
    },
    keys = {
        's',
        'S',
        'gs',
    },
    config = function ()
        require('leap').create_default_mappings()
    end,
}
