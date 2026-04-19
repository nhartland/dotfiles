return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                'python',
                'markdown',
                'markdown_inline',
                'bash',
                'yaml',
                'lua',
                'vimdoc',
                'latex',
                'html',
                'css',
                'javascript',
                'mermaid',
                'norg',
                'typescript',
                'sql',
            },
        })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end
}
