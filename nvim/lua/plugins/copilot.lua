-- Copilot.
return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                -- Disable the built-in mapping, we'll configure it in nvim-cmp.
                panel = { enabled = false },
                keymap = { accept = false },
            },
            filetypes = { markdown = true },
        },
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
                window = {
                    layout = 'horizontal', -- 'vertical', 'horizontal', 'float', 'replace'
                    width = 0.5,           -- fractional width of parent, or absolute width in columns when > 1
                    height = 0.3,          -- fractional height of parent, or absolute height in rows when > 1
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
