return { {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                'r',
                'python',
                'markdown',
                'markdown_inline',
                'julia',
                'bash',
                'yaml',
                'lua',
                'vim',
                'query',
                'vimdoc',
                'latex', -- requires tree-sitter-cli (installed automatically via Mason)
                'html',
                'css',
                'dot',
                'javascript',
                'mermaid',
                'norg',
                'typescript',
                'sql',
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
},
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    }
}
