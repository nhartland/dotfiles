return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "-" },
                topdelete    = { text = "-" },
                changedelete = { text = "~" },
            },
            current_line_blame = false, -- Show inline git blame
        })
    end
}
