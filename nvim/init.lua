-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local f = require("custom.functions")

-- Specify the master python venv for use by python plugins
-- This is mainly used by Molten
local venv_path = f.get_master_poetry_venv()
if venv_path and venv_path ~= "" then
    vim.g.python3_host_prog = venv_path
else
    vim.notify("Cannot find master poetry env")
end

-- This should be imported before lualine/lazy
local _ = require("custom.mycolour")
local _ = require("custom.love_runner")
local _ = require("config.lazy")
local _ = require("config.lsp")
local _ = require("config.keymaps")
local _ = require("config.options")
local _ = require("config.spell")
