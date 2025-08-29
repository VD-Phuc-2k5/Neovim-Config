-- options.lua
local opt = vim.opt

-- General options
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.showmode = false
opt.clipboard = 'unnamedplus'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = 'menuone,noselect'
opt.termguicolors = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true

-- UI
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.hlsearch = true

-- Text formatting
opt.textwidth = 80
opt.formatoptions:append("t")  -- Auto-wrap text using textwidth
opt.formatoptions:append("c")  -- Auto-wrap comments using textwidth
opt.formatoptions:append("r")  -- Continue comments when pressing Enter
opt.formatoptions:append("q")  -- Allow formatting comments with gq
opt.formatoptions:remove("o")  -- Don't continue comments with o/O

-- Folding
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
