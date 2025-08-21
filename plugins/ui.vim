" ====== UI CONFIGURATION ======
colorscheme dracula

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dracula'

" Floaterm
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
if has('win32') || has('win64')
  let g:floaterm_shell = 'powershell -NoExit'
endif

lua <<EOF
-- Bufferline
require("bufferline").setup{}

-- Indent-o-matic
require('indent-o-matic').setup{
  max_lines = 2048,
  standard_widths = { 2, 4, 8 },
}

require('gitsigns').setup {
  signs = {
    add          = { text = '│', numhl = 'GitSignsAdd' },
    change       = { text = '│', numhl = 'GitSignsChange' },
    delete       = { text = '_', numhl = 'GitSignsDelete' },
    topdelete    = { text = '‾', numhl = 'GitSignsDelete' },
    changedelete = { text = '~', numhl = 'GitSignsChange' },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

-- Cấu hình nvim-tree
local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  
  -- Mappings mặc định
  api.config.mappings.default_on_attach(bufnr)
  
  -- Custom mappings
  vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
  vim.keymap.set('n', 'A', function()
    local node = api.tree.get_node_under_cursor()
    local path = node and node.absolute_path or api.tree.get_cwd()
    if node and node.type == 'file' then
      path = vim.fn.fnamemodify(path, ':h')
    end
    vim.ui.input({ prompt = 'Create folder: ' .. path .. '/', default = '' }, function(name)
      if name and name ~= '' then
        local folder_path = path .. '/' .. name
        vim.fn.mkdir(folder_path, 'p')
        api.tree.reload()
      end
    end)
  end, opts('Create New Folder'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'm', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
end

-- Nvim-tree setup with Git safety checks
local function safe_git_setup()
  -- Check if we're in a git repository
  local git_check = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
  local is_git_repo = vim.v.shell_error == 0
  
  return {
    enable = is_git_repo,
    ignore = false,
    show_on_dirs = is_git_repo,
    show_on_open_dirs = is_git_repo,
    timeout = 400,
  }
end

require('nvim-tree').setup {
  hijack_cursor = true,
  on_attach = my_on_attach,
  view = {
    width = 35,
    side = 'left',
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = "name",
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        modified = "●",
        folder = {
          arrow_closed = ">",
          arrow_open = "v",
          default = "📁",
          open = "📂",
          empty = "📁",
          empty_open = "📂",
          symlink = "🔗",
          symlink_open = "🔗",
        },
        git = {
          unstaged = "M",
          staged = "S",
          unmerged = "U",
          renamed = "R",
          untracked = "?",
          deleted = "D",
          ignored = "I",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    debounce_delay = 15,
    update_root = true,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false, -- Disable diagnostics to avoid icon errors
    show_on_dirs = false,
    show_on_open_dirs = false,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E",
    },
  },
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = { '^.DS_Store$', },
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = safe_git_setup(),
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
}

-- Treesitter configuration with error handling
local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if treesitter_ok then
  treesitter.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "go", "html", "css" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
    },
    textobjects = {
      enable = false, -- Disable if not using nvim-treesitter-textobjects
    },
  }
else
  vim.notify("nvim-treesitter not found", vim.log.levels.WARN)
end

-- Telescope
local telescope_ok, telescope = pcall(require, 'telescope')
if telescope_ok then
  telescope.setup{
    defaults = {
      file_ignore_patterns = {
        "node_modules", "%.git", "%.DS_Store"
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
    }
  }
else
  vim.notify("telescope not found", vim.log.levels.WARN)
end

-- Autopairs
local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if autopairs_ok then
  autopairs.setup {}
else
  vim.notify("nvim-autopairs not found", vim.log.levels.WARN)
end

-- TS Autotag
local autotag_ok, autotag = pcall(require, 'nvim-ts-autotag')
if autotag_ok then
  autotag.setup()
else
  vim.notify("nvim-ts-autotag not found", vim.log.levels.WARN)
end

-- Indent blankline (version 3 syntax)
local ibl_ok, ibl = pcall(require, 'ibl')
if ibl_ok then
  ibl.setup {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = false,
      highlight = { "Function", "Label" },
      priority = 500,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  }
else
  -- Fallback to version 2 syntax if version 3 not available
  local old_ibl_ok, old_ibl = pcall(require, 'indent_blankline')
  if old_ibl_ok then
    old_ibl.setup {
      show_current_context = true,
      show_current_context_start = true,
      char = '│',
      context_char = '│',
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    }
  else
    vim.notify("indent-blankline not found", vim.log.levels.WARN)
  end
end

EOF
