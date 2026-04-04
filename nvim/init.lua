-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- This should be imported before lualine/lazy
local _ = require("custom.mycolour")
local _ = require("custom.love_runner")
local _ = require("config.lazy")
local _ = require("config.lsp")
local _ = require("config.keymaps")
local _ = require("config.options")
local _ = require("config.spell")
