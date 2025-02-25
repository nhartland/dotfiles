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

-- help conceallevel
-- Sets concealed text to single character
o.conceallevel = 1

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
o.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "   ▏" }

-- Search and other options
o.incsearch = true
o.ignorecase = true
o.smartcase = true

vim.diagnostic.config({
    signs = true,
    underline = true,
    -- Not sure if I prefer this being false or true
    virtual_text = true,
    float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
    },
    update_in_insert = true, -- default to false
    severity_sort = false,   -- default to false
})

vim.opt.backup = true
vim.opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.wildmode = "list:longest,full"
vim.o.wildmenu = true
