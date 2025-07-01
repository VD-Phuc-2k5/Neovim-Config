" ====== GO-SPECIFIC SETTINGS ======
setlocal noexpandtab
setlocal nolist

" Disable vim-go LSP to prevent conflicts with coc.nvim
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

" Go-specific keymaps
nnoremap <buffer> <leader>r :GoRun<CR>
nnoremap <buffer> <leader>b :GoBuild<CR>

" Format Go files với goimports
autocmd BufWritePre <buffer> silent! execute '!goimports -w %' | edit
