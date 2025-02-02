-- lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Example: Remap j/k for visual lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Use capital J, K as page up/down
--vim.keymap.set('n', 'J', '<PageDown>', { noremap = true, silent = true })
--vim.keymap.set('n', 'K', '<PageUp>', { noremap = true, silent = true })

-- Additional global mappings...
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
