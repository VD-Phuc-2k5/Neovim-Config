" init.vim
let g:config_dir = stdpath('config')

" load core configurations
execute 'source ' . g:config_dir . '/core/settings.vim'
execute 'source ' . g:config_dir . '/core/keymaps.vim'
execute 'source ' . g:config_dir . '/core/commands.vim'

" load plugins
execute 'source ' . g:config_dir . '/plugins/plugins.vim'
execute 'source ' . g:config_dir . '/plugins/ui.vim'
execute 'source ' . g:config_dir . '/plugins/lsp.vim'
execute 'source ' . g:config_dir . '/plugins/navigation.vim'
execute 'source ' . g:config_dir . '/plugins/git.vim'
execute 'source ' . g:config_dir . '/plugins/utils.vim'
