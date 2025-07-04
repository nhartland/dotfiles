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

-- Setting this to anything else messes with Telescope
o.winborder = 'none'

-- Open splits to the right and below by default
vim.o.splitright = true
vim.o.splitbelow = true

-- help conceallevel
-- Sets concealed text to single character
o.conceallevel = 0

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

-- Add fzf to runtimepath
o.runtimepath:append("/opt/homebrew/opt/fzf")

-- Search and other options
o.incsearch = true
o.ignorecase = true
o.smartcase = true

vim.diagnostic.config({
    signs = true,
    underline = true,
    -- Not sure if I prefer this being false or true
    virtual_text = true,
    --virtual_lines = {
    --    enabled = false,
    --    current_line = false,
    --},
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

vim.o.completeopt = "menuone,noinsert,noselect,popup"
vim.o.wildmode = "list:longest,full"
vim.o.wildmenu = true
