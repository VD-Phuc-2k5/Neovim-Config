-- keymaps.lua
local keymap = vim.keymap.set

-- Clear search highlighting
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Better paste
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Quick save and quit
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file (insert mode)" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Split windows
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })
keymap("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })

-- File explorer
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- Buffer navigation
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap("n", "<C-c>", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- NEW: Close current tab/buffer
keymap("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close current tab/buffer" })
keymap("n", "<C-x>", "<cmd>bd<CR>", { desc = "Close current tab/buffer" })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Code folding shortcuts
keymap("n", "<leader>zo", "zo", { desc = "Open fold under cursor" })
keymap("n", "<leader>zc", "zc", { desc = "Close fold under cursor" })
keymap("n", "<leader>za", "za", { desc = "Toggle fold under cursor" })

-- Additional useful keymaps
keymap("n", "<leader>/", "<cmd>noh<CR>", { desc = "Clear search highlight" })
keymap("n", "x", '"_x', { desc = "Delete char without yanking" })

-- Quick line operations
keymap("n", "<leader>dd", '"_dd', { desc = "Delete line without yanking" })
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Terminal toggle
keymap("n", "<leader>t", "<cmd>terminal<CR>", { desc = "Open terminal" })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Manual formatting (only when explicitly called)
keymap("n", "<leader>fm", "<cmd>Format<CR>", { desc = "Format buffer manually" })
