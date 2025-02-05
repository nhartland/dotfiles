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

