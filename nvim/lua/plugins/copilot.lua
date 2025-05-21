-- Copilot.
return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            -- I don't find the panel useful.
            panel = { enabled = false },
            copilot_model = "gpt-4o-copilot",
            suggestion = {
                enabled = false,
                auto_trigger = true,
                -- Use alt to interact with Copilot.
                keymap = {
                    -- Disable the built-in mapping, we'll configure it in nvim-cmp.
                    accept = false,
                    accept_word = '<M-w>',
                    accept_line = '<M-l>',
                    next = '<M-]>',
                    prev = '<M-[>',
                    dismiss = '/',
                },
            },
            filetypes = { markdown = true },
        },
        config = function(_, opts)
            local cmp = require 'cmp'
            local copilot = require 'copilot.suggestion'

            require('copilot').setup(opts)

            local function set_trigger(trigger)
                vim.b.copilot_suggestion_auto_trigger = trigger
                vim.b.copilot_suggestion_hidden = not trigger
            end

            -- Hide suggestions when the completion menu is open.
            cmp.event:on('menu_opened', function()
                if copilot.is_visible() then
                    copilot.dismiss()
                end
                set_trigger(false)
            end)
        end,
        dependencies = {
            "zbirenbaum/copilot-cmp",
            config = function()
                require("copilot_cmp").setup()
            end
        }
    },
    {
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            dependencies = {
                { "nvim-lua/plenary.nvim", branch = "master" },
            },
            version = '*',
            build = "make tiktoken",
            opts = {
                auto_insert_mode = true,
                --model = "copilot:claude-3.7-sonnet",
                window = {
                    layout = 'horizontal',  -- 'vertical', 'horizontal', 'float', 'replace'
                    width = 0.5,            -- fractional width of parent, or absolute width in columns when > 1
                    height = 0.3,           -- fractional height of parent, or absolute height in rows when > 1
                    -- Options below only apply to floating windows
                    relative = 'editor',    -- 'editor', 'win', 'cursor', 'mouse'
                    border = 'single',      -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                    row = nil,              -- row position of the window, default is centered
                    col = nil,              -- column position of the window, default is centered
                    title = 'Copilot Chat', -- title of chat window
                    footer = nil,           -- footer of chat window
                    zindex = 1,             -- determines if window is on top or below other floating windows
                },
            },
            keys = {
                -- Show prompts actions with telescope
                {
                    "<leader>ap",
                    function()
                        require("CopilotChat").select_prompt({
                            context = {
                                "buffers",
                            },
                        })
                    end,
                    desc = "CopilotChat - Prompt actions",
                },
                -- Custom input for CopilotChat
                {
                    "<leader>ai",
                    "<cmd>CopilotChat<cr>",
                    desc = "CopilotChat - Ask input",
                },
            },
        }

    } }
