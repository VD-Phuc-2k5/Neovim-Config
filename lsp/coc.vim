" ====== coc.vim ======
" COC extensions
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-go'
  \ ]

" COC memory 
let g:coc_node_args = ['--max-old-space-size=2048']
let g:coc_disable_startup_warning = 1

" Performance settings
set updatetime=500

" COC user config
let g:coc_user_config = {
  \ 'suggest.noselect': v:true,
  \ 'suggest.enablePreview': v:false,
  \ 'suggest.maxCompleteItemCount': 10,
  \ 'suggest.timeout': 1500,
  \ 'diagnostic.refreshOnInsertMode': v:false,
  \ 'diagnostic.checkCurrentLine': v:true,
  \ 'diagnostic.virtualText': v:true,
  \ 'typescript.preferences.includePackageJsonAutoImports': 'off',
  \ }

" Disable problematic auto-uninstall
let g:coc_disable_uncaught_error = 1
