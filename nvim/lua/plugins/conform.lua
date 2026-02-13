return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
        formatters_by_ft = {
            python = { "ruff_organize_imports", "ruff_format" },
            markdown = { "prettier" },
            lua = { lsp_format = "fallback" },
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
