" ====== BASIC SETTINGS ======
set encoding=UTF-8
set autoindent smartindent
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set mouse=a
set completeopt=menuone,noinsert,noselect,preview
set termguicolors
set clipboard=unnamedplus
set updatetime=300
set timeoutlen=500
set hidden nobackup nowritebackup
set cmdheight=1
set shortmess+=c
set signcolumn=yes
set relativenumber
set number

" Leader key
let mapleader = "\<Space>"

" Highlight yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
augroup END

" Terminal settings
if has('nvim')
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * startinsert
endif
