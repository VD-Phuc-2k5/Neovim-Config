" ====== C++ CONFIGURATION ======

" Enhanced C++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

" C++ specific file settings
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType c setlocal shiftwidth=4 tabstop=4 expandtab

" C++ specific keybindings
autocmd FileType cpp nnoremap <buffer> <leader>cc :!g++ -std=c++17 -o %:r % && ./%:r<CR>
autocmd FileType cpp nnoremap <buffer> <leader>cd :!g++ -std=c++17 -g -o %:r %<CR>
autocmd FileType c nnoremap <buffer> <leader>cc :!gcc -o %:r % && ./%:r<CR>
autocmd FileType c nnoremap <buffer> <leader>cd :!gcc -g -o %:r %<CR>

" C++ template snippets (nếu có UltiSnips)
autocmd FileType cpp inoremap <buffer> <C-t> template<typename T><CR>

lua <<EOF
-- C++ specific autopairs rules
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

-- Thêm rules cho C++
npairs.add_rules({
  -- Template brackets for C++
  Rule('<', '>')
    :with_pair(function(opts)
      return vim.bo.filetype == 'cpp'
    end)
    :with_move(function(opts)
      return opts.char == '>'
    end)
    :with_cr(function() return false end),
    
  -- C++ brace rules
  Rule('{', '}')
    :with_pair(function(opts)
      return vim.tbl_contains({'cpp', 'c'}, vim.bo.filetype)
    end),
    
  -- Include guard helper
  Rule('#include <', '>')
    :with_pair(function(opts)
      return vim.tbl_contains({'cpp', 'c'}, vim.bo.filetype)
    end)
})

-- Update treesitter config for C++
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- existing languages...
    "cpp", "c"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"cpp", "c"}
  },
  indent = {
    enable = true
  }
})
EOF
