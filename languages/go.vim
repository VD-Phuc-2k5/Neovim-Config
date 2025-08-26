" ====== go.vim ======
" Go configuration
augroup go_config
  autocmd!
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go setlocal synmaxcol=200
  " Essential go mappings
  autocmd FileType go nnoremap <buffer> <leader>r :GoRun<CR>
  autocmd FileType go nnoremap <buffer> <leader>b :GoBuild<CR>
  autocmd FileType go nnoremap <buffer> <leader>t :GoTest<CR>
  " Manual format 
  autocmd FileType go nnoremap <buffer> <leader>fmt :GoFmt<CR>
augroup END

" DISABLE all auto-format features
let g:go_fmt_autosave = 0
let g:go_fmt_command = "gofmt"
let g:go_imports_autosave = 0
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_mod_fmt_autosave = 0
