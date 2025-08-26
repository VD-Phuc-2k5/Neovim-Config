" ====== settings.vim ======
set encoding=UTF-8
set autoindent smartindent
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set mouse=a
set completeopt=menuone,noinsert,noselect
set termguicolors
set clipboard=unnamedplus
set updatetime=300
set timeoutlen=500
set hidden nobackup nowritebackup noswapfile
set cmdheight=1
set shortmess+=cI
set signcolumn=yes
set relativenumber number
set lazyredraw
set ttyfast
set synmaxcol=300
set regexpengine=1

let mapleader = "\<Space>"

" Performance optimizations
set scrolljump=8
set scrolloff=3
set sidescrolloff=5
set display=lastline

" Highlight yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 150})
augroup END

" Terminal settings
if has('nvim')
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
  autocmd TermOpen * startinsert
endif

" Global error suppression wrapper
function! SafeCall(command)
  try
    execute a:command
  catch
    " Silently ignore errors
  endtry
endfunction

" Performance autocmds
augroup performance_opts
  autocmd!
  " Reduce syntax complexity for large files
  autocmd BufWinEnter * if line('$') > 500 | syntax sync minlines=50 maxlines=100 | endif
  autocmd BufWinEnter * if line('$') > 1000 | setlocal foldmethod=manual | endif
  
  " Disable relativenumber in insert mode for performance
  autocmd InsertEnter * if &number | set norelativenumber | endif
  autocmd InsertLeave * if &number | set relativenumber | endif
augroup END

" Memory cleanup
augroup memory_cleanup
  autocmd!
  autocmd BufUnload * call SafeCall('silent! bdelete!')
  autocmd VimLeavePre * call SafeCall('wshada!')
augroup END
