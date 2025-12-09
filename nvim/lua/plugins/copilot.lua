-- Copilot.
return {
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
                model = "gemini-2.5-pro",
                window = {
                    layout = 'horizontal',
                    width = 0.5,
                    height = 0.3,
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
