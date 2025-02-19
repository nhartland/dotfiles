-- LSP Plugins
return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {
                    progress = {
                        display = {
                            render_limit = 16, -- How many LSP messages to show at once
                            done_ttl = 3,      -- How long a message should persist after completion
                            done_icon = "",
                        },
                    },
                    notification = {
                        override_vim_notify = true,
                    },
                },
            },
            -- Allows extra capabilities provided by nvim-cmp
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
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

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                    -- Find references for the word under your cursor.
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                    map("<leader>h", vim.lsp.buf.hover, "[H]over [I]nfo")

                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- TODO: Re-enable if cmp installed
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                basedpyright = {
                    capabilities = capabilities,
                    on_init = function(client)
                        local venv_path = require("functions").get_poetry_venv()
                        if venv_path and venv_path ~= "" then
                            client.config.settings.python.pythonPath = venv_path .. "/bin/python"
                            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                        end
                    end,
                    settings = {
                        basedpyright = {
                            analysis = {
                                -- Use this to instead use ruff's organiser
                                disableOrganizeImports = false,
                                diagnosticMode = "openFilesOnly",
                                typeCheckingMode = "basic",
                                useLibraryCodeForTypes = true,
                                --reportMissingTypeStubs = "none",
                                --reportUnknownMemberType = false,
                                --reportUnknownVariableType = "none",
                                --reportUnknownArgumentType = "none",
                                --reportUnknownLambdaType = "none",
                                --ignore = { '*' },
                            },
                        },
                        python = {},
                    },
                },
                bashls = {
                    capabilities = capabilities,
                },
                sqlls = {
                    capabilities = capabilities,
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = { "vim", "love" },
                            },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format Lua code
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup({
                ensure_installed = {},
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
