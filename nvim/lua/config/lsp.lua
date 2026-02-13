-- Defined in init.lua
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.semanticTokens.multilineTokenSupport = true

vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' },
})

vim.lsp.enable({
    'luals',
    'basedpyright',
    'ruff',
    'bashls',
    'sqlls',
    "yamlls",
    "dockerls",
    "markdown-oxide",
})


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider = nil
        end

        -- Use internal formatting for bindings like gq.
        vim.bo[event.buf].formatexpr = nil

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        map("<leader>hi", vim.lsp.buf.hover, "[H]over [I]nfo")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    end,
})
