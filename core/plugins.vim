" ====== plugins.vim ======
call plug#begin('~/.local/share/nvim/plugged')
" Core UI
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File management
Plug 'nvim-tree/nvim-web-devicons'  
Plug 'nvim-tree/nvim-tree.lua'

" Navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language-specific 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }

" Utilities
Plug 'voldikss/vim-floaterm'
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()
