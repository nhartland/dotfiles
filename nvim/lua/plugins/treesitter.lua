return { {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "bash", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "sql", "python" },
            --ensure_installed = "all",
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
},
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            separator = '═'
        }
    }
}
