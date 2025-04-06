return
{
    'saghen/blink.cmp',
    -- use a release tag to download pre-built binaries
    dependencies = {
        "giuxtaposition/blink-cmp-copilot",
    },
    version = '1.*',
    opts = {
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'super-tab' },
        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200
            }
        },
        signature = { enabled = true },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
            per_filetype = {
                sql = { 'snippets', 'dadbod', 'buffer' },
            },
            -- add vim-dadbod-completion to your completion providers
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },

    },
    opts_extend = { "sources.default" }
}
