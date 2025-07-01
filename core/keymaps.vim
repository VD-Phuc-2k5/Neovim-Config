" ====== KEY MAPPINGS ======

" Navigation
nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" Buffer management
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-c> :bdelete<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Terminal
nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>

" COC keymaps
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>ai <Plug>(coc-codeaction)
nnoremap <silent> <leader>d :call CocActionAsync('diagnosticInfo')<CR>

" COC completion
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-y>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
