-- LSP Plugins
return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { "williamboman/mason.nvim", opts = {} },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            -- Ensure the servers and tools above are installed
            local ensure_installed = {
                "basedpyright",
                "lua-language-server",
                "bash-language-server",
                "prettier",
                "ruff",
                "sqlfluff",
                "sqlls",
                "yaml-language-server",
                "dockerfile-language-server",
            }
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
        end
    },
    {
        -- Allows extra capabilities provided by nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}
