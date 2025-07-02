-- lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Open diagnostic float
vim.keymap.set("n", "<leader>hd", "<cmd>lua vim.diagnostic.open_float()<cr>")

-- Escape maps to exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Remap j/k for visual lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
