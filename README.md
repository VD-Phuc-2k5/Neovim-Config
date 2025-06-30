# Neovim configuration

## 1. Vim-plug installation

### Unix, Linux

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Linux (Flatpak)

```bash
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Windows (PowerShell)

```bash
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

## v1. vim.init

```bash
" ====== BASIC SETTINGS ======
set encoding=UTF-8
set relativenumber
set number
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set completeopt=menuone,noinsert,noselect
set termguicolors
set clipboard=unnamed,unnamedplus
set updatetime=300
set timeoutlen=500
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set signcolumn=yes

" ====== PLUGINS ======
call plug#begin('~/.config/nvim/plugged')

" --- Giao diện và công cụ ---
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'

" --- Hỗ trợ React/JS/TS/HTML/CSS ---
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

" --- Auto Complete, Formatter ---
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jose-elias-alvarez/null-ls.nvim'

" --- Tìm kiếm nhanh với Telescope ---
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" --- Tô màu nâng cao với Treesitter ---
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" --- Git integration ---
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" --- Bufferline ---
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" --- Terminal nổi ---
Plug 'voldikss/vim-floaterm'

" --- Debugging ---
Plug 'williamboman/mason.nvim'
Plug 'jay-babu/mason-nvim-dap.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" --- Công cụ hỗ trợ ---
Plug 'mattn/emmet-vim'
Plug 'nvim-neotest/nvim-nio'

call plug#end()

" ====== MÀU SẮC ======
colorscheme dracula

" ====== AIRLINE CONFIG ======
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme = 'dracula'

" ====== MAPPING ======
" Leader key
let mapleader = ' '

" NERDTree
nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Telescope
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Buffer navigation
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <silent> <C-c> :bdelete<CR>

" ====== SAVE MAPPING ======
nnoremap <C-s> :w!<CR>
inoremap <C-s> <Esc>:w!<CR>a

" Move lines up/down
nnoremap <A-Up> :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==
inoremap <A-Up> <Esc>:m .-2<CR>==gi
inoremap <A-Down> <Esc>:m .+1<CR>==gi
vnoremap <A-Up> :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv

" ====== INLAY HINTS CONFIG ======
lua << EOF
-- Kiểm tra version Neovim và hỗ trợ inlay hints
local nvim_version = vim.version()
local supports_inlay_hints = nvim_version.major > 0 or (nvim_version.major == 0 and nvim_version.minor >= 10)

if not supports_inlay_hints then
  vim.notify("Inlay hints require Neovim 0.10+. Current version: " .. vim.version(), vim.log.levels.WARN)
end

-- Biến global để theo dõi trạng thái
_G.inlay_hints_enabled = false

-- Hàm toggle inlay hints với COC.nvim
function _G.toggle_inlay_hints()
  if not supports_inlay_hints then
    vim.notify("Inlay hints not supported in this Neovim version", vim.log.levels.ERROR)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  -- Kiểm tra COC.nvim trước
  if vim.fn.exists(':CocCommand') == 2 then
    -- Sử dụng COC.nvim cho inlay hints
    if _G.inlay_hints_enabled then
      vim.fn.CocAction('runCommand', 'typescript.preferences.includePackageJsonAutoImports', 'off')
      vim.notify("COC inlay hints disabled", vim.log.levels.INFO)
      _G.inlay_hints_enabled = false
    else
      vim.fn.CocAction('runCommand', 'typescript.preferences.includePackageJsonAutoImports', 'on')
      vim.notify("COC inlay hints enabled", vim.log.levels.INFO)
      _G.inlay_hints_enabled = true
    end
    return
  end

  -- Fallback to native LSP
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  local has_inlay_hint_support = false

  for _, client in ipairs(clients) do
    if client.server_capabilities.inlayHintProvider then
      has_inlay_hint_support = true
      break
    end
  end

  if not has_inlay_hint_support then
    vim.notify("No LSP client with inlay hints support found", vim.log.levels.WARN)
    return
  end

  -- Toggle native inlay hints
  _G.inlay_hints_enabled = not _G.inlay_hints_enabled
  vim.lsp.inlay_hint.enable(_G.inlay_hints_enabled, { bufnr = bufnr })

  local status = _G.inlay_hints_enabled and "enabled" or "disabled"
  vim.notify("Inlay hints " .. status, vim.log.levels.INFO)
end

-- Auto-enable cho TypeScript/JavaScript với COC
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('InlayHintsSetup', {}),
  pattern = {'*.ts', '*.tsx', '*.js', '*.jsx'},
  callback = function()
    if supports_inlay_hints and vim.fn.exists(':CocCommand') == 2 then
      -- Delay để đảm bảo COC đã load
      vim.defer_fn(function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
        if filetype == 'typescript' or filetype == 'typescriptreact' then
          _G.inlay_hints_enabled = true
        end
      end, 1000)
    end
  end,
})

-- Mapping cho inlay hints
vim.keymap.set('n', '<leader>ih', _G.toggle_inlay_hints, {desc = 'Toggle inlay hints'})
EOF

" ====== CÀI ĐẶT COC INLAY HINTS ======
" Bật inlay hints cho TypeScript trong COC
autocmd FileType typescript,typescriptreact,javascript,javascriptreact call coc#config('typescript.inlayHints.parameterNames.enabled', 'all')
autocmd FileType typescript,typescriptreact,javascript,javascriptreact call coc#config('typescript.inlayHints.parameterTypes.enabled', v:true)
autocmd FileType typescript,typescriptreact,javascript,javascriptreact call coc#config('typescript.inlayHints.variableTypes.enabled', v:true)
autocmd FileType typescript,typescriptreact,javascript,javascriptreact call coc#config('typescript.inlayHints.propertyDeclarationTypes.enabled', v:true)
autocmd FileType typescript,typescriptreact,javascript,javascriptreact call coc#config('typescript.inlayHints.functionLikeReturnTypes.enabled', v:true)
autocmd FileType typescript,typescriptreact,javascript,javascriptreact call coc#config('typescript.inlayHints.enumMemberValues.enabled', v:true)

" ====== DEBUG SETUP ======
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-eslint',
  \ ]

" ====== CẤU HÌNH EMMET ======
let g:user_emmet_mode = 'i'
let g:user_emmet_leader_key = '<C-e>'
let g:user_emmet_settings = {
\ 'javascript.jsx': {
\   'extends': 'jsx',
\ },
\ 'typescript.tsx': {
\   'extends': 'jsx',
\ },
\}

" Tab/Shift-Tab trong completion
autocmd FileType html,css,javascript,javascriptreact,typescriptreact inoremap <buffer><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
autocmd FileType html,css,javascript,javascriptreact,typescriptreact inoremap <buffer><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Enter để confirm completion
autocmd FileType html,css,javascript,javascriptreact,typescriptreact inoremap <buffer><expr> <CR>
      \ pumvisible() ? "\<C-y>" : "\<CR>"

" ====== Mapping COC ======
nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Auto format khi lưu file
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.json :call CocAction('format')

" Nhận diện file JSX/TSX
augroup filetype_jsx
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
augroup END

lua << EOF
-- Cấu hình Telescope
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git"},
    layout_config = {
      horizontal = {
        preview_width = 0.6,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

-- Cấu hình Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "html", "css", "json", "lua" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}

-- Cấu hình Gitsigns
require('gitsigns').setup()

-- Cấu hình Bufferline
require("bufferline").setup{}
EOF

" ====== DEBUG CONFIGURATION ======
lua << EOF
-- Cấu hình Mason để quản lý debug adapters
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Cấu hình Mason DAP để tự động cài đặt debug adapters
require("mason-nvim-dap").setup({
  ensure_installed = {
    "node2",
    "chrome",
    "js"
  },
  automatic_installation = true,
})

local dap = require('dap')
local dapui = require('dapui')

-- Cấu hình Node.js debug adapter
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"},
}

-- Cấu hình Chrome debug adapter
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = {vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"}
}

-- Cấu hình debug cho JavaScript
dap.configurations.javascript = {
  {
    name = "Launch Node.js Program",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Attach to Node.js Process",
    type = "node2",
    request = "attach",
    processId = require'dap.utils'.pick_process,
    sourceMaps = true,
    protocol = "inspector",
  },
  {
    name = "Launch Chrome",
    type = "chrome",
    request = "launch",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
  }
}

-- Cấu hình debug cho TypeScript
dap.configurations.typescript = {
  {
    name = "Launch TypeScript (ts-node)",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    runtimeExecutable = "ts-node",
    runtimeArgs = {"--transpile-only"},
    console = "integratedTerminal",
  },
  {
    name = "Launch TypeScript (tsx)",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    runtimeExecutable = "tsx",
    console = "integratedTerminal",
  },
  {
    name = "Debug Jest Tests",
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/node_modules/.bin/jest",
    args = {"--runInBand", "--no-cache", "${relativeFile}"},
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  }
}

-- Copy configurations cho JSX/TSX
dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.typescript

-- Cấu hình DAP UI
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
})

-- Cấu hình virtual text
require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  virt_text_pos = 'eol',
  all_frames = false,
  virt_lines = false,
})

-- Tự động mở/đóng UI khi debug
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
EOF

" ====== DEBUG KEYMAPS ======
" Toggle debug UI - sửa lại mapping
nnoremap <silent> <C-r> :lua require'dapui'.toggle()<CR>
nnoremap <silent> <leader>db :lua require'dapui'.toggle()<CR>

" Breakpoint operations
nnoremap <silent> <leader>bb :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>bc :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>bl :lua require'dap'.list_breakpoints()<CR>
nnoremap <silent> <leader>br :lua require'dap'.clear_breakpoints()<CR>

" Debug controls
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <S-F11> :lua require'dap'.step_out()<CR>
nnoremap <silent> <S-F5> :lua require'dap'.terminate()<CR>

" Debug info
nnoremap <silent> <leader>dr :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dh :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <silent> <leader>ds :lua require'dap.ui.widgets'.scopes()<CR>

" Debug REPL
nnoremap <silent> <leader>dp :lua require'dap'.repl.open()<CR>

" ====== FLOATERM CONFIG ======
nnoremap <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

if has('win32') || has('win64')
  let g:floaterm_shell = 'powershell -NoExit'
endif

" Highlight yanked text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 300})
augroup END

" Auto close NERDTree nếu là cửa sổ cuối cùng
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Git commands
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>

" ====== COPY/PASTE/UNDO ======
vnoremap <C-c> "+y
nnoremap <C-v> "+p
inoremap <C-v> <Esc>"+pa
nnoremap <C-z> u
inoremap <C-z> <Esc>ua

" ====== UTILITY COMMANDS ======
" Cài đặt dependencies cho debugging
command! InstallDebugDeps :MasonInstall node-debug2-adapter chrome-debug-adapter js-debug-adapter
command! InstallTSRuntime :!npm install -g ts-node tsx nodemon
command! DebugInfo :lua print("DAP Status: " .. vim.inspect(require('dap').status()))
command! CheckHealth :checkhealth mason | :checkhealth dap
```

## v2. vim.init

```bash
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
set norelativenumber
set number

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

" Better Indentation
Plug 'Darazaki/indent-o-matic'

call plug#end()

" ====== PLUGIN SETUP ======
lua <<EOF

-- Cấu hình indent-o-matic
require('indent-o-matic').setup{
  max_lines = 2048,
  standard_widths = { 2, 4, 8 },
}

-- Cấu hình nâng cao cho autopairs
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'}, 
  }
})

-- Thêm rule cho HTML/JSX
npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function(opts)
      return vim.tbl_contains({'text', 'html'}, vim.bo.filetype)
    end)
    :with_move(function() return true end)
    :with_cr(function() return false end),  
})

-- Tích hợp autopairs với completion
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Telescope setup
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git"},
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.6 }
  }
}

-- Setup gitsigns
require('gitsigns').setup()

-- Setup bufferline
require("bufferline").setup{}
EOF

" ====== COLORSCHEME ======
colorscheme dracula

" ====== KEY MAPPINGS ======
let mapleader = "\<Space>"

" Navigation
nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" Buffer management
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-c> :bdelete<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Terminal
nnoremap <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>
let g:floatern_width = 0.9
let g:floaterm_height = 0.9
if has('win32') || has('win64')
  let g:floaterm_shell = 'powershell -NoExit'
endif
" ====== PLUGIN CONFIGURATION ======
" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dracula'

" ====== COC CONFIGURATION ======
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-go',
  \ ]

" Block coc-import-cost from being installed/loaded
autocmd VimEnter * silent! call coc#util#uninstall_extension('coc-import-cost')
let g:coc_user_config = {'import-cost.enable': v:false}

" Improved tab completion
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-y>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Go to definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Auto import
nmap <silent> <leader>ai <Plug>(coc-codeaction) " Nhấn trên import để fix
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Format on save (non-Go files)
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.json silent! call CocAction('format')

" ====== LANGUAGE-SPECIFIC SETTINGS ======
" TypeScript/React
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact

" Go settings (disable coc-go to prevent conflicts)
let g:go_code_completion_enabled = 0
let g:go_fmt_autosave = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" Emmet only for relevant filetypes
let g:user_emmet_install_global = 0
autocmd FileType html,css,jsx,tsx,typescriptreact,javascriptreact EmmetInstall

" ====== UI ENHANCEMENTS ======
" Show diagnostics
nnoremap <silent> <leader>d :call CocActionAsync('diagnosticInfo')<CR>

" Highlight yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
augroup END

" ====== SMART BRACKETS & AUTO IMPORT ======
" Tự động đóng tag HTML/JSX
autocmd FileType html,javascriptreact,typescriptreact,jsx,tsx setlocal iskeyword+=-

" auto import cho TypeScript
autocmd FileType typescript,typescriptreact setlocal formatoptions+=j 

" Tự động organize imports khi save
autocmd BufWritePre *.ts,*.tsx call CocAction('runCommand', 'editor.action.organizeImport')

" ====== FIX GO CONFLICTS & TERMINAL ISSUES ======

" Tắt hoàn toàn LSP của vim-go để tránh xung đột với coc.nvim
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

" Sử dụng coc.nvim thay vim-go cho LSP
let g:go_gopls_enabled = 0
autocmd FileType go setlocal omnifunc=go#complete#Complete

" Cấu hình riêng cho terminal
if has('nvim')
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * startinsert
endif

" ====== KEY MAPPINGS FIXES ======
" Terminal toggle an toàn
nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

if has('win32') || has('win64')
  let g:floaterm_shell = 'powershell -NoExit'
endif
" Fix conflict with Go commands
autocmd FileType go nnoremap <buffer> <leader>r :GoRun<CR>
autocmd FileType go nnoremap <buffer> <leader>b :GoBuild<CR>

" ====== GO-SPECIFIC SETTINGS ======
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal nolist

" Format Go files với goimports thay vì coc
autocmd BufWritePre *.go silent! execute '!goimports -w %' | edit

" Disable auto-completion cho Go trong coc (sử dụng vim-go)
" autocmd FileType go let b:coc_suggest_disable = 1

" ====== FIX NERDTREE CONFLICTS ======
let g:NERDTreeChDirMode = 2
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden = 1

" ====== CUSTOM COMMANDS ======
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 EslintFix :CocCommand eslint.executeAutofix
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')

```

## 3. coc-settings.json (:CocConfig)

```bash
{
  "snippets.userSnippetsDirectory": "~/.config/nvim/snippets",
  "snippets.extends": {
    "javascriptreact": ["javascript"],
    "typescriptreact": ["typescript", "javascript"]
  },

  // ====== FORMATTING ======
  "prettier.enable": true,
  "prettier.semi": true,
  "prettier.singleQuote": true,
  "prettier.tabWidth": 2,
  "prettier.trailingComma": "es5",
  "prettier.printWidth": 100,
  "prettier.bracketSpacing": true,
  "prettier.jsxBracketSameLine": false,
  "prettier.arrowParens": "avoid",
  "prettier.endOfLine": "lf",

  "coc.preferences.formatOnSaveFiletypes": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss",
    "less",
    "html",
    "json"
  ],

  // ====== LINTING ======
  "eslint.enable": true,
  "eslint.autoFixOnSave": true,
  "eslint.filetypes": ["javascript", "javascriptreact", "typescript", "typescriptreact"],
  "eslint.validate": ["javascript", "javascriptreact", "typescript", "typescriptreact"],

  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },

  // ====== AUTOCOMPLETION ======
  "suggest.enablePreview": true,
  "suggest.maxCompleteItemCount": 15,
  "suggest.timeout": 3000,
  "suggest.snippetIndicator": " ►",

  // ====== TYPESCRIPT/JAVASCRIPT ======
  "tsserver.enable": true,
  "tsserver.formatOnType": true,
  "tsserver.preferences.includePackageJsonAutoImports": "auto",
  "tsserver.preferences.importModuleSpecifier": "relative",
  "tsserver.preferences.quoteStyle": "single",
  "tsserver.enableJavascript": true,
  "tsserver.implicitProjectConfig.experimentalDecorators": true,
  "tsserver.implicitProjectConfig.strictNullChecks": true,

  // ====== EMMET ======
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "typescript": "typescriptreact",
    "vue": "html"
  },
  "emmet.showExpandedAbbreviation": "always",
  "emmet.triggerExpansionOnTab": true,

  // ====== UI & DIAGNOSTICS ======
  "diagnostic.checkCurrentLine": true,
  "diagnostic.refreshOnInsertMode": false,
  "diagnostic.virtualText": true,
  "diagnostic.virtualTextPrefix": " » ",
  "diagnostic.virtualTextLines": 1,
  "diagnostic.errorSign": "✗",
  "diagnostic.warningSign": "⚠",
  "diagnostic.infoSign": "ℹ",
  "diagnostic.hintSign": "➤",

  "signature.enable": true,
  "signature.target": "float",

  "hover.target": "float",
  "hover.enable": true,

  // ====== PERFORMANCE OPTIMIZATIONS ======
  "workspace.ignoredFolders": [
    "**/node_modules/**",
    "**/dist/**",
    "**/build/**",
    "**/.git/**",
    "**/.next/**",
    "**/out/**"
  ],
  "coc.preferences.extensionUpdateCheck": "weekly",
  "coc.preferences.currentFunctionSymbolAutoUpdate": true,
  "javascript.inlayHints.variableTypes.enabled": true,
  "javascript.inlayHints.parameterNames.enabled": "all",
  "javascript.inlayHints.parameterTypes.enabled": true,
  "javascript.inlayHints.propertyDeclarationTypes.enabled": true,
  "javascript.inlayHints.functionLikeReturnTypes.enabled": true,
  "javascript.inlayHints.variableTypes.suppressWhenTypeMatchesName": true,
  "javascript.inlayHints.parameterNames.suppressWhenArgumentMatchesName": true,
  "typescript.inlayHints.variableTypes.enabled": true,
  "typescript.inlayHints.parameterTypes.enabled": true,
  "typescript.inlayHints.functionLikeReturnTypes.enabled": true,
  "typescript.inlayHints.propertyDeclarationTypes.enabled": true,
  "typescript.inlayHints.parameterNames.enabled": "all",
  "typescript.inlayHints.enumMemberValues.enabled": true,
  "typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName": true,
  "typescript.inlayHints.parameterNames.suppressWhenArgumentMatchesName": true
}
```
