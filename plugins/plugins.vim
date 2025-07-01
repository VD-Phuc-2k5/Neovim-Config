" ====== PLUGINS ======
call plug#begin('~/.local/share/nvim/plugged')

" UI & Tools
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'lukas-reineke/indent-blankline.nvim'

" Language Support
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" LSP & Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jose-elias-alvarez/null-ls.nvim'

" Navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Utilities
Plug 'voldikss/vim-floaterm'
Plug 'mattn/emmet-vim'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'Darazaki/indent-o-matic'

call plug#end()
