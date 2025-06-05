return {
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        version = '1.*',
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            signature = {
                enabled = true
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                menu =
                {
                    draw = {
                        treesitter = { 'lsp' },
                        columns = {
                            { "label", "label_description", gap = 1 }, { "kind", gap = 1 }, { "source_id" }
                        }
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            sources = {
                -- Removed 'buffer' from here
                default = { 'lsp', 'path', 'snippets' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        }
    }
}
