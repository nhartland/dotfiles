-- lua/options.lua

local o = vim.opt

-- General Neovim options
o.number = true
o.cursorline = true
o.mouse = ""
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.backup = true
o.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }

-- Search and other options
o.incsearch = true
o.ignorecase = true
o.smartcase = true
