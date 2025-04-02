return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        lazy = true,
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20

            -- Output as virtual text. Allows outputs to always be shown, works with images, but can
            -- be buggy with longer images
            vim.g.molten_virt_text_output = true

            vim.g.molten_image_location = 'both'
            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = true

            --vim.g.molten_auto_open_html_in_browser = true
        end,
        keys = {
            { "<leader>mi", ":MoltenInit<CR>:QuartoActivate<CR>", desc = "[M]olten [I]nit" },
        },
        dependencies = {
            {
                "3rd/image.nvim",
                lazy = true,
                opts = {
                    backend = "kitty", -- whatever backend you would like to use
                    max_width = 200,
                    max_height = 12,
                    max_height_window_percentage = math.huge,
                    max_width_window_percentage = math.huge,
                    window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
                    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                },
                init = function()
                    package.path = package.path ..
                        ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
                    package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
                end,
            },
            {
                "quarto-dev/quarto-nvim",
                lazy = true,
                --ft = { "quarto", "markdown" },
                init = function()
                    vim.keymap.set("n", "<S-CR>", "<cmd>lua require('quarto.runner').run_cell()<cr>",
                        { desc = "run cell", silent = true })
                end,
                opts = {
                    lspFeatures = {
                        -- NOTE: put whatever languages you want here:
                        languages = { "lua", "python" },
                        chunks = "all",
                        diagnostics = {
                            enabled = true,
                            triggers = { "BufWritePost" },
                        },
                        completion = {
                            enabled = true,
                        },
                    },
                    keymap = {
                        --    -- NOTE: setup your own keymaps:
                        --    hover = "H",
                        --    definition = "gd",
                        --    rename = "<leader>rn",
                        --    references = "gr",
                        --    format = "<leader>gf",
                    },
                    codeRunner = {
                        enabled = true,
                        default_method = "molten",
                    },
                },
                dependencies = {
                    "jmbuhr/otter.nvim",
                    "nvim-treesitter/nvim-treesitter",
                },
            },

        },
    },
}
