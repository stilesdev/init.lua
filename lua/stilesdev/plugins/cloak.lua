return {
    'laytan/cloak.nvim',
    opts = {
        cloak_length = 10,
        patterns = {
            {
                file_pattern = '.env*',
                cloak_pattern = '=.+',
            },
            {
                file_pattern = '*.env',
                cloak_pattern = '=.+',
            },
        },
    },
}
