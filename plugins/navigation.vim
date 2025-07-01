" ====== NAVIGATION PLUGINS ======
lua <<EOF
-- Telescope setup
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git"},
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.6 }
  }
}
EOF
