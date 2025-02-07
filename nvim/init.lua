-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local _ = require('options')
local _ = require('keymaps')
local _ = require('spell')
local _ = require('lazy_bootstrap')
local _ = require("lazy").setup("plugins")
