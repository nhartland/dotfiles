return
{
    {
        "toppair/peek.nvim",
        version = '*',
        cmd = "PeekOpen",
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
        -- Replaces obsidian.nvim rendering
        'MeanderingProgrammer/render-markdown.nvim',
        version = '*',
        ft = 'markdown',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            -- Enable most rendering across all modes
            render_modes = true,
            heading = {
                enabled = true,
                sign = false,
                position = 'inline'
            },
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
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        cmd = { "Obsidian" },
        event = {
            "BufReadPre ~/vault/**/*.md",
            "BufNewFile ~/vault/**/*.md",
        },
        keys = {
            { "<leader>os", "<cmd>Obsidian search<cr>",    mode = "n", desc = "[O]bsidian [S]earch" },
            { "<leader>on", "<cmd>Obsidian new<cr>",       mode = "n", desc = "[O]bsidian [N]ew" },
            { "<leader>ot", "<cmd>Obsidian today<cr>",     mode = "n", desc = "[O]bsidian [T]oday" },
            { "<leader>oy", "<cmd>Obsidian yesterday<cr>", mode = "n", desc = "[O]bsidian [Y]esterday" }
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
                folder = "daily",
                date_format = "YYYY-MM-DD",
                alias_format = "MMMM D, YYYY",
                default_tags = { "daily-notes" },
            },

            note = {
                template = "note.md",
            },

            note_id_func = function(title)
                local date = os.date("%Y-%m-%d")
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return date .. "-" .. suffix
            end,

            frontmatter = { enabled = true },

            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",
            preferred_link_style = "markdown",

            templates = {
                folder = "templates",
                date_format = "D MMMM, YYYY",
                time_format = "HH:mm",
                substitutions = {},
            },

            legacy_commands = false,

            callbacks = {
                enter_note = function()
                    vim.keymap.set("n", "gd", "<cmd>Obsidian follow_link<cr>", { buffer = true })
                    vim.keymap.set("n", "<cr>", "<cmd>Obsidian toggle_checkbox<cr>", { buffer = true })
                end,
            },

            picker = {
                name = "telescope.nvim",
            },
        }
    }
}
