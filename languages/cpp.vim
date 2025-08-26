" ====== cpp.vim ======
" C++ configuration
augroup cpp_config
  autocmd!
  autocmd FileType cpp,c setlocal commentstring=//\ %s
  autocmd FileType cpp,c setlocal shiftwidth=4 tabstop=4 expandtab
  autocmd FileType cpp,c setlocal synmaxcol=200
  " Essential C++ mappings
  autocmd FileType cpp nnoremap <buffer> <leader>cc :!g++ -std=c++17 -O2 -o %:r % && ./%:r<CR>
  autocmd FileType c nnoremap <buffer> <leader>cc :!gcc -std=c11 -O2 -o %:r % && ./%:r<CR>
augroup END

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
