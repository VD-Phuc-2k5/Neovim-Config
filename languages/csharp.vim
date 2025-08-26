" ====== csharp.vim ======
" C# configuration
augroup cs_config
  autocmd!
  autocmd FileType cs setlocal tabstop=5 shiftwidth=4 expandtab
  autocmd FileType cs setlocal synmaxcol=200
  " Essential C# mappings
  autocmd FileType cs nnoremap <buffer> <leader>gd :OmniSharpGotoDefinition<CR>
  autocmd FileType cs nnoremap <buffer> <leader>gf :OmniSharpFindUsages<CR>
  autocmd FileType cs nnoremap <buffer> <leader>gr :OmniSharpRename<CR>
  autocmd FileType cs nnoremap <buffer> <leader>ca :OmniSharpGetCodeActions<CR>
  autocmd FileType cs nnoremap <buffer> <leader>rb :!dotnet build<CR>
  autocmd FileType cs nnoremap <buffer> <leader>rr :!dotnet run<CR>
augroup END

let g:OmniSharp_timeout = 5
let g:OmniSharp_server_stdio = 1
