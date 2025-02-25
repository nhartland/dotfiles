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
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { "nvim-telescope/telescope-frecency.nvim",   version = "*" }
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
        pickers = {
            defaults = {
                dynamic_preview_title = true,
                path_display = { shorten = 3 },
                theme = "ivy",
            },
            find_files = {
                prompt_title = false,  -- Removes the unnecessary title
                prompt_prefix = "[Find Files] ",
                results_title = false, -- Removes the unnecessary title
                preview = { hide_on_startup = true },
                theme = "ivy",
                layout_config = { height = 0.30 },
            },
            live_grep = {
                dynamic_preview_title = true,
                path_display = { shorten = 3 },
            }
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("frecency")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("base16_colorpicker")
    end,
    keys = {
        { "<leader>fc", function() return require("telescope.builtin").find_files({ cwd = "~/dotfiles/" }) end, desc = "Telescope find config" },
        { "<leader>ff", telescope_with_root("find_files"),                                                      desc = "Telescope find files" },
        { "<leader>fg", telescope_with_root("live_grep"),                                                       desc = "Telescope live grep" },
        { "<leader>fb", telescope_with_root("buffers"),                                                         desc = "Telescope buffers" },
        { "<leader>fh", telescope_with_root("help_tags"),                                                       desc = "Telescope help tags" },
        { "<leader>e",  function() return require("telescope").extensions.frecency.frecency() end,              desc = "Frecency-based file navigation" },
    }
}
