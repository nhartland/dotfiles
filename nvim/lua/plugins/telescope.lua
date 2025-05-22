local f = require('custom.functions')
local function telescope_with_root(picker)
    -- Helper function for initialising Telescope keybindings such that they run in the project root.
    -- TODO: Adjust such that find_project_root is called newly for each buffer rather than on opening vim
    return function()
        local builtin = require("telescope.builtin")
        local root = f.find_project_root()
        builtin[picker]({ cwd = root })
    end
end

return {
    {
        'nvim-telescope/telescope.nvim',
        --version = '*'
        --branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { "nvim-telescope/telescope-ui-select.nvim",  version = "*" }
        },
        event = "VeryLazy",
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "%.pyc",
                    "%.wav", "%.ogg", "%.jfxr",
                    "%.png", "%.jpg", "%.jpeg", "%.bmp", "%.gif",
                    "%.zip",
                    "%.aif", "%.ttf",
                }
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_ivy {
                        layout_config = { height = 0.30 },
                    } }
            },
            pickers = {
                live_grep = {
                    dynamic_preview_title = true,
                    path_display = { "smart", shorten = { len = 3 } },
                    wrap_results = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            width = 0.9,
                            height = 0.9,
                            preview_height = 0.6,
                            preview_cutoff = 0
                        }
                    },
                },
                buffers = {
                    prompt_prefix = "[Find Buffer] ",
                    theme = "ivy",
                    prompt_title = false,
                    results_title = false,
                    sort_mru = true,
                    preview = { hide_on_startup = true },
                    layout_config = { height = 0.30 },
                },
                find_files = {
                    prompt_prefix = "[Find Files] ",
                    theme = "ivy",
                    prompt_title = false,
                    results_title = false,
                    layout_config = { height = 0.30 },
                    preview = { hide_on_startup = true },
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("base16_colorpicker")
            require("telescope").load_extension("ui-select")
        end,
        keys = {
            { "<leader>fc", function() return require("telescope.builtin").find_files({ cwd = "~/dotfiles/" }) end, desc = "Telescope find config" },
            { "<leader>ff", telescope_with_root("find_files"),                                                      desc = "Telescope find files" },
            { "<leader>fg", telescope_with_root("live_grep"),                                                       desc = "Telescope live grep" },
            { "<leader>fb", telescope_with_root("buffers"),                                                         desc = "Telescope buffers" },
            { "<leader>fh", telescope_with_root("help_tags"),                                                       desc = "Telescope help tags" },
        }
    },
}
