return {
    "mbbill/undotree",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Open Undo Tree" },
    },
    init = function()
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_ShortIndicators = 1
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}
