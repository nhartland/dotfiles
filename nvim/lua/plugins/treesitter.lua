return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                'python',
                'markdown',
                'markdown_inline',
                'bash',
                'yaml',
                'lua',
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
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,
        })
    end
}
