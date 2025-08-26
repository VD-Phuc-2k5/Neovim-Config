" ====== appearance.vim ======
colorscheme dracula

" Airline optimizations
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dracula'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_section_z = '%l/%L :%c'

" Floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
if has('win32') || has('win64')
  let g:floaterm_shell = 'powershell'
endif

lua <<EOF
-- Performance-optimized Lua configuration
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Module not found: " .. module, vim.log.levels.WARN)
    return nil
  end
  return result
end

-- Bufferline with reduced features
local bufferline = safe_require("bufferline")
if bufferline then
  bufferline.setup{
    options = {
      diagnostics = false,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
      offsets = {{filetype = "NvimTree", text = "File Explorer"}},
      max_name_length = 25,
    }
  }
end

-- Gitsigns
local gitsigns = safe_require('gitsigns')
if gitsigns then
  gitsigns.setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '-' },
      topdelete = { text = '‾' },
      changedelete = { text = '≈' },
      untracked = { text = '?' },
    },
    signcolumn = true,
    current_line_blame = false,
    update_debounce = 200,
    max_file_length = 10000,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '<leader>hs', gs.stage_hunk)
      map('n', '<leader>hr', gs.reset_hunk)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    end
  }
end

local nvim_tree = safe_require('nvim-tree')
if nvim_tree then
  local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')
    
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    
    api.config.mappings.default_on_attach(bufnr)
    
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  end

  nvim_tree.setup {
    on_attach = my_on_attach,
    view = {
      width = 30,
      side = 'left',
    },
    renderer = {
      group_empty = false,
      highlight_git = true,
      highlight_opened_files = "name",
      indent_width = 2,
      icons = {
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { '^.git$', '^.DS_Store$' },
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = false,
      },
    },
    diagnostics = { enable = false },
    log = { enable = false },
  }
end

-- Treesitter
local ts_configs = safe_require("nvim-treesitter.configs")
if ts_configs then
  ts_configs.setup {
    ensure_installed = {
      "c", "lua", "vim", "vimdoc",
      "javascript", "typescript", "go", "html", "css"
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 50 * 1024 -- 50 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
        
        local buftype = vim.api.nvim_get_option_value('buftype', {buf = buf})
        return buftype ~= ''
      end,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = { enable = false },
    textobjects = { enable = false },
    indent = { enable = false },
  }
end

local telescope = safe_require('telescope')
if telescope then
  telescope.setup{
    defaults = {
      file_ignore_patterns = {
        "%.git/.*"
      },
      layout_strategy = "horizontal",
      layout_config = { 
        preview_width = 0.5,
        height = 0.8,
        width = 0.9
      },
      vimgrep_arguments = {
        'rg', '--color=never', '--no-heading',
        '--with-filename', '--line-number', '--column',
        '--smart-case', '--hidden'
      },
    },
    pickers = {
      find_files = {
        hidden = true
      }
    }
  }
end

-- autopairs
local autopairs = safe_require('nvim-autopairs')
if autopairs then
  autopairs.setup({
    check_ts = false,
    enable_check_bracket_line = false,
    ignored_next_char = "[%w%.]",
    disable_in_macro = true,
    disable_in_visualblock = true,
    disable_filetype = { "TelescopePrompt" },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%)%>%]%)%}%,]]=],
      end_key = '$',
      keys = 'qwertyuiop',
      check_comma = true,
      highlight = 'Search',
    },
  })
end

-- indent-blankline
local ibl = safe_require('ibl')
if ibl then
  ibl.setup {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble",
        "lazy", "mason", "notify", "toggleterm", "lazyterm", "NvimTree"
      },
    },
  }
end
EOF
