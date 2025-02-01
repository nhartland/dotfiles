-- LSP settings
require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}
require("mason-lspconfig").setup {
    ensure_installed = { "ruff", "basedpyright", "lua_ls" },
}


-- Function that sets standard capabilities for LSP
local function on_attach(client, bufnr)
    -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
    local opts = { noremap = true, silent = true }
    -- Setup gd to go to declaration/definition
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)


    -- Set up format on save (only if the server supports formatting)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format { async = false, id = client.id }
                vim.diagnostic.show()
            end,
        })
    end
end

-- Default capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Table of LSP servers with their settings
local servers = {
    ruff = {
        on_attach = on_attach,
        -- ruff settings (if any) can be added here:
        init_options = {
            settings = {
                args = {},
            },
        },
    },
    basedpyright = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            basedpyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
                analysis = {
                    useLibraryCodeForTypes = false,
                    typeCheckingMode = "standard",
                    --ignore = { '*' },
                },
            },
        },
    },
    lua_ls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = { 'vim', 'love' },
                },
            }
        }
    },
}

local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
    lspconfig[server].setup(config)
end
