" ====== C++ CONFIGURATION ======
"
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

" ====== ALE Configuration for C++ ======
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'cpp': ['clangd', 'cppcheck', 'clang-tidy', 'gcc'],
\ 'c': ['clangd', 'cppcheck', 'clang-tidy', 'gcc']
\}

let g:ale_fixers = {
\ 'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
\ 'c': ['clang-format', 'remove_trailing_lines', 'trim_whitespace']
\}

" Enable ALE fixing on save for C++
let g:ale_fix_on_save = 1

" ALE C++ specific settings
let g:ale_cpp_cppcheck_options = '--enable=all --std=c++17 --suppress=missingIncludeSystem'
let g:ale_cpp_clang_options = '-std=c++17 -Wall -Wextra -Wpedantic'
let g:ale_cpp_gcc_options = '-std=c++17 -Wall -Wextra -Wpedantic'

" Clang-tidy configuration
let g:ale_cpp_clangtidy_checks = [
\ 'bugprone-*',
\ 'cert-*',
\ 'clang-analyzer-*',
\ 'cppcoreguidelines-*',
\ 'google-*',
\ 'hicpp-*',
\ 'llvm-*',
\ 'misc-*',
\ 'modernize-*',
\ 'performance-*',
\ 'portability-*',
\ 'readability-*',
\ '-google-readability-todo',
\ '-cppcoreguidelines-avoid-magic-numbers',
\ '-readability-magic-numbers'
\]

let g:ale_cpp_clangtidy_options = '-std=c++17'

" ALE display settings
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_sign_style_error = '✘'
let g:ale_sign_style_warning = '⚠'

" Enable ALE completion where available
let g:ale_completion_enabled = 0

" Show ALE errors in airline
let g:airline#extensions#ale#enabled = 1

" Project-specific configuration
let g:ale_cpp_clangformat_use_local_file = 1
let g:ale_cpp_clangd_options = '--compile-commands-dir=build'

" ====== C++ Specific Keybindings ======
" Compilation keybindings
autocmd FileType cpp nnoremap <buffer> <leader>cc :!g++ -std=c++17 -Wall -Wextra -O2 -o %:r % && ./%:r<CR>
autocmd FileType cpp nnoremap <buffer> <leader>cd :!g++ -std=c++17 -Wall -Wextra -g -o %:r %<CR>
autocmd FileType c nnoremap <buffer> <leader>cc :!gcc -std=c11 -Wall -Wextra -O2 -o %:r % && ./%:r<CR>
autocmd FileType c nnoremap <buffer> <leader>cd :!gcc -std=c11 -Wall -Wextra -g -o %:r %<CR>

" Linting keybindings
autocmd FileType cpp,c nnoremap <buffer> <leader>li :ALEInfo<CR>
autocmd FileType cpp,c nnoremap <buffer> <leader>lf :ALEFix<CR>
autocmd FileType cpp,c nnoremap <buffer> <leader>ln :ALENext<CR>
autocmd FileType cpp,c nnoremap <buffer> <leader>lp :ALEPrevious<CR>
autocmd FileType cpp,c nnoremap <buffer> <leader>lt :ALEToggle<CR>
autocmd FileType cpp,c nnoremap <buffer> <leader>ld :ALEDetail<CR>

" Format with clang-format
autocmd FileType cpp,c nnoremap <buffer> <leader>cf :!clang-format -i %<CR>

" Custom lint check
autocmd FileType cpp,c nnoremap <buffer> <leader>cl :CppLint<CR>

" Template snippets
autocmd FileType cpp inoremap <buffer> <C-t> template<typename T><CR>

" ====== Custom C++ Linting Function ======
function! CppLintCustom()
  " Run custom linting checks
  let l:file = expand('%')
  let l:output = []
  
  " Check for common C++ issues
  let l:lines = getline(1, '$')
  let l:line_num = 1
  
  for line in l:lines
    " Check for potential issues
    if line =~ 'using namespace std'
      call add(l:output, l:line_num . ': Warning: Avoid "using namespace std" in headers')
    endif
    
    if line =~ '#include.*\.h"' && line !~ '#include.*\.hpp"'
      call add(l:output, l:line_num . ': Info: Consider using .hpp extension for C++ headers')
    endif
    
    if line =~ 'malloc\|free\|calloc\|realloc'
      call add(l:output, l:line_num . ': Warning: Consider using new/delete or smart pointers instead of malloc/free')
    endif
    
    let l:line_num += 1
  endfor
  
  " Display results
  if len(l:output) > 0
    echo join(l:output, "\n")
  else
    echo "No custom lint issues found!"
  endif
endfunction

command! CppLint call CppLintCustom()

" ====== Auto-format configuration ======
" Enhanced format on save for C++ files
autocmd BufWritePre *.cpp,*.cc,*.cxx,*.c,*.h,*.hpp silent! call CocAction('format')

" ====== Lua Configuration for C++ ======
lua <<EOF
-- C++ specific autopairs rules
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

-- C++ specific rules
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
    end),
    
  -- Namespace rules
  Rule('namespace ', ' {')
    :with_pair(function(opts)
      return vim.bo.filetype == 'cpp'
    end)
    :with_move(function(opts)
      return opts.char == '}'
    end)
})

-- Update treesitter config for C++
require('nvim-treesitter.configs').setup({
  ensure_installed = {
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
