return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            python = { "ruff_organize_imports", "ruff_format" },
            markdown = { "prettier" },
            lua = { "stylua", lsp_format = "fallback" },
        },
        formatters = {
            prettier = {
                prepend_args = { "--prose-wrap", "always" },
            },
        },
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = "fallback",
        },
    },
}
