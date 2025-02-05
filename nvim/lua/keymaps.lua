-- lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Example: Remap j/k for visual lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
