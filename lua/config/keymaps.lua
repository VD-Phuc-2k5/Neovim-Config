-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
