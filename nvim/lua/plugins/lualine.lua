return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        theme = "auto",

        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                {
                    require('functions').get_relative_path,
                    color = { fg = "#ffaa00" }
                } -- Ensure function is executed
            },
            lualine_x = { 'searchcount', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        }
    }
}
