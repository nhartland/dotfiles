local f = require('functions')
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
        {
            "nvim-telescope/telescope-frecency.nvim",
            -- install the latest stable version
            version = "*",
            config = function()
                require("telescope").load_extension "frecency"
            end,
        }
    },
    keys = {
        { "<leader>ff", telescope_with_root("find_files"),                                         desc = "Telescope find files" },
        { "<leader>fg", telescope_with_root("live_grep"),                                          desc = "Telescope live grep" },
        { "<leader>fb", telescope_with_root("buffers"),                                            desc = "Telescope buffers" },
        { "<leader>fh", telescope_with_root("help_tags"),                                          desc = "Telescope help tags" },
        { "<leader>e",  function() return require("telescope").extensions.frecency.frecency() end, desc = "Frecency-based file navigation" },

    }
}
