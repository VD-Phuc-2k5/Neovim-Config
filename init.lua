-- init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

print("🧛 Dracula Neovim configuration loaded successfully!")
