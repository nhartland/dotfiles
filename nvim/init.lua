-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local _ = require('lazy_bootstrap')
local _ = require("lazy").setup("plugins")
local _ = require('keymaps')
local _ = require('options')
local _ = require('spell')
local f = require('functions')

local base16_theme_fname = vim.fn.expand(vim.env.HOME .. '/.config/.base16_theme')
f.set_colorscheme(vim.fn.readfile(base16_theme_fname)[1])
