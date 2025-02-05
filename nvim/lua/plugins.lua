-- lua/plugins.lua
-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none", -- speeds up the clone process by skipping blobs
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",    -- recommended: use the stable branch
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins using lazy.nvim with your existing plugins
require("lazy").setup({

    -- Utility Plugins
    { "junegunn/goyo.vim" },
    { "lervag/vimtex" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "+" },
                    change       = { text = "~" },
                    delete       = { text = "-" },
                    topdelete    = { text = "-" },
                    changedelete = { text = "~" },
                },
                current_line_blame = true, -- Show inline git blame
            })
        end
    },
    -- LSP Setup
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            {
                'j-hui/fidget.nvim',
                opts = {
                    progress = {
                        display = {
                            skip_history = false
                        },
                        lsp = {
                            log_handler = true
                        }
                    },
                    notification = {
                        override_vim_notify = true,    -- Ensure Fidget intercepts vim.notify
                        filter = vim.log.levels.DEBUG, -- Minimum notifications level
                    },
                }
            },

            -- Allows extra capabilities provided by nvim-cmp
            --'hrsh7th/cmp-nvim-lsp',
        }
    },
    -- Completion
    --{
    --    "hrsh7th/nvim-cmp",
    --    dependencies = {
    --        "hrsh7th/cmp-nvim-lsp",
    --        "hrsh7th/cmp-buffer",
    --        "hrsh7th/cmp-path",
    --        "hrsh7th/cmp-vsnip",
    --        "hrsh7th/vim-vsnip",
    --    }
    --},
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        }
    },
    -- Command line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = { theme = "auto" }
            })
        end
    },

})
