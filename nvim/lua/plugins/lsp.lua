-- LSP Plugins
return {
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
                "markdown-oxide",
            }
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
        end
    },
}
