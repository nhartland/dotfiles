return { {
    "nvim-treesitter/nvim-treesitter",
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
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            separator = '═'
        }
    }
}
