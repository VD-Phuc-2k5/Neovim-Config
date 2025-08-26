" ====== javascript.vim ======
" JavaScript/TypeScript configuration
augroup js_ts_config
  autocmd!
  autocmd BufNewFile,BufRead *.tsx setfiletype typescriptreact
  autocmd BufNewFile,BufRead *.jsx setfiletype javascriptreact
augroup END
