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
    { "junegunn/goyo.vim" },
    { "lervag/vimtex" },
    { "ConradIrwin/vim-bracketed-paste" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },

})
