" ====== UI CONFIGURATION ======
colorscheme dracula

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dracula'

" NERDTree
let g:NERDTreeChDirMode = 2
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden = 1

" Floaterm
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
if has('win32') || has('win64')
  let g:floaterm_shell = 'powershell -NoExit'
endif

lua <<EOF
require("bufferline").setup{}

require('indent-o-matic').setup{
  max_lines = 2048,
  standard_widths = { 2, 4, 8 },
}
EOF
