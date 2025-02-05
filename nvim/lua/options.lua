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

-- Enable break indent
o.breakindent = true
-- Decrease update time
o.updatetime = 250
-- Decrease mapped sequence wait time
o.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search and other options
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- Colorscheme
vim.cmd("colorscheme jellybeans")
vim.cmd("colorscheme Tomorrow-Night-Bright")

-- Enable update_in_insert
vim.diagnostic.config({
    update_in_insert = true,
    signs = true,
})

vim.opt.backup = true
vim.opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.wildmode = "list:longest,full"
vim.o.wildmenu = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
