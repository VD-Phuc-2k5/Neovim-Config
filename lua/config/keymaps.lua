-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Delete buffer
vim.keymap.set("n", "<C-d>", "<cmd>bd<CR>", { desc = "Delete Buffer" })

-- Open / Close terminal
vim.keymap.set(
  "n",
  "<C-o>",
  "<cmd>ToggleTerm<CR>",
  { desc = "Toggle Terminal" }
)

vim.keymap.set(
  "t",
  "<C-o>",
  "<cmd>ToggleTerm<CR>",
  { desc = "Toggle Terminal" }
)
