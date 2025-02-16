return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            theme = "base16",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" }, -- Solid square blocks
        },
        tabline = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    require("functions").get_relative_path,
                    --                    color = { bg = 'NONE', fg = "white" },
                },
            },
            lualine_x = {
                "datetime",
            },
            lualine_y = {},
            lualine_z = {
                -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = { "filename" },
            lualine_x = { "searchcount", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    },
}
