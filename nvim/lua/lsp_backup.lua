-- LSP settings

vim.lsp.log.set_level("debug")

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
                vim.lsp.buf.format({ async = false, id = client.id })
                vim.diagnostic.show()
            end,
        })
    end
end

-- Default capabilities
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Table of LSP servers with their settings
local servers = {
    --ruff = {
    --    on_attach = on_attach,
    --    capabilities = capabilities,
    --    -- ruff settings (if any) can be added here:
    --    init_options = {
    --        settings = {
    --            args = {},
    --        },
    --    },
    --},
    pyright = {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = function(client)
            local venv_path = get_poetry_venv()
            if venv_path and venv_path ~= "" then
                client.config.settings.python.pythonPath = venv_path .. "/bin/python"
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
        end,
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = false,
                analysis = {
                    useLibraryCodeForTypes = false,
                    typeCheckingMode = "standard",
                    --ignore = { '*' },
                },
            },
            python = {},
        },
    },
    lua_ls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                --			runtime = {
                --				version = "LuaJIT",
                --				path = vim.split(package.path, ";"),
                --			},
                diagnostics = {
                    globals = { "vim", "love" },
                },
            },
        },
    },
}

-- Install above defined servers
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua", -- Used to format Lua code
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
    lspconfig[server].setup(config)
end
