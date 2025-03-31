return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    --ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    cmd = { "ObsidianToday", "ObsidianTomorrow", "ObsidianYesterday", "ObsidianNew", "ObsidianSearch" },
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        -- refer to `:h file-pattern` for more examples
        "BufReadPre " .. vim.fn.expand "~" .. "/vault/**/*.md",
        "BufNewFile " .. vim.fn.expand "~" .. "/vault/**/*.md",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
        {
            "toppair/peek.nvim",
            ft = { "markdown", "quarto" },
            build = "deno task --quiet build:fast",
            config = function()
                require("peek").setup(
                    { app = 'browser' }
                )
                vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
                vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
            end,
        },
        {
            -- Currently just using this for inline latex
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
            opts = {
                -- Disable most rendering
                render_modes = true,
                checkbox = {
                    render_modes = true,
                    enabled = true,
                },
                -- Enable latex rendering when in insert mode
                latex = {
                    enabled = true,
                    render_modes = { 'i' },
                },
                code = {
                    render_modes = true,
                    style = 'language',
                    width = 'block',
                    min_width = 45,
                    left_pad = 2,
                    language_pad = 2,
                },
                dash = {
                    enabled = true,
                    render_modes = true,
                    icon = '─',
                    width = 'full',
                    left_margin = 0,
                    highlight = 'RenderMarkdownDash',
                },
                pipe_table = {
                    enabled = true,
                    render_modes = true,
                },

            },
        },
    },
    keys = {
        { "<leader>os", "<cmd>ObsidianSearch<cr>",    mode = "n", desc = "[O]bsidian [S]earch" },
        { "<leader>on", "<cmd>ObsidianNew<cr>",       mode = "n", desc = "[O]bsidian [N]ew" },
        { "<leader>ot", "<cmd>ObsidianToday<cr>",     mode = "n", desc = "[O]bsidian [T]oday" },
        { "<leader>oy", "<cmd>ObsidianYesterday<cr>", mode = "n", desc = "[O]bsidian [Y]esterday" }
    },
    opts = {
        ui = {
            -- Handled by render-markdown
            enable = false
        },
        workspaces = {
            {
                name = "notes",
                path = "~/vault/notes",
            },
        },

        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "daily",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, default tags to add to each new daily note created.
            default_tags = { "daily-notes" },
        },

        -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
        completion = {
            -- Set to false to disable completion.
            nvim_cmp = true,
            -- Trigger completion at 2 chars.
            min_chars = 2,
        },

        -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
        -- way then set 'mappings = {}'.
        mappings = {
            -- Overrides the 'gd' mapping to work on markdown/wiki links within your vault.
            ["gd"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
            -- Smart action depending on context, either follow link or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            }
        },

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,

        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",


        -- Either 'wiki' or 'markdown'.
        preferred_link_style = "markdown",

        -- Optional, for templates (see below).
        templates = {
            folder = "templates",
            --date_format = "%Y-%m-%d",
            date_format = "%-d %B, %Y",
            time_format = "%H:%M",
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {},
        },

        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
            name = "telescope.nvim",
            -- Optional, configure key mappings for the picker. These are the defaults.
            -- Not all pickers support all mappings.
            note_mappings = {
                -- Create a new note from your query.
                new = "<C-x>",
                -- Insert a link to the selected note.
                insert_link = "<C-l>",
            },
            tag_mappings = {
                -- Add tag(s) to current note.
                tag_note = "<C-x>",
                -- Insert a tag at the current location.
                insert_tag = "<C-l>",
            },
        },

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        sort_by = "modified",
        sort_reversed = true,

        -- Set the maximum number of lines to read from notes on disk when performing certain searches.
        search_max_lines = 1000,

        -- Optional, determines how certain commands open notes. The valid options are:
        -- 1. "current" (the default) - to always open in the current window
        -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
        -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
        open_notes_in = "current",
    }
}
