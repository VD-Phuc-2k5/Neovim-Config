" ====== init.vim ======
let g:config_dir = stdpath('config')

" Load core configurations
execute 'source ' . g:config_dir . '/core/settings.vim'
execute 'source ' . g:config_dir . '/core/plugins.vim'
execute 'source ' . g:config_dir . '/core/keymaps.vim'
execute 'source ' . g:config_dir . '/ui/appearance.vim'
execute 'source ' . g:config_dir . '/lsp/coc.vim'
execute 'source ' . g:config_dir . '/languages/init.vim'
execute 'source ' . g:config_dir . '/utils/commands.vim'
