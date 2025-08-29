-- init.lua

vim.g.loaded_perl_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = "C:/Users/duyvo/scoop/apps/python/current/python.exe"

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

print("🧛 Dracula Neovim configuration loaded successfully!")
