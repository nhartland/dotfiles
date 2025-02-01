-- lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Example: Remap j/k for visual lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Additional global mappings...
