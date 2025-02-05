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

local function get_poetry_venv()
    local output = vim.fn.system("poetry env info --path")
    return vim.fn.trim(output)
end

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
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.notify("hello")

-- Table of LSP servers with their settings
local servers = {
    ruff = {
        on_attach = on_attach,
        capabilities = capabilities,
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
        on_init = function(client)
            local venv_path = get_poetry_venv()
            if venv_path and venv_path ~= "" then
                -- Ensure `settings` and `python` exist before assignment
                client.config.settings = client.config.settings or {}
                client.config.settings.python = client.config.settings.python or {}
                client.config.settings.python.pythonPath = venv_path .. "/bin/python"

                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
        end,
        settings = {
            basedpyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = false,
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
