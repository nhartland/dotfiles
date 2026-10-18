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
            -- Only use stylua in projects with a stylua.toml; otherwise fall back to lua_ls.
            stylua = { require_cwd = true },
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
