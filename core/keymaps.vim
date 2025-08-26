" ====== keymaps.vim ======
let mapleader = " "

" Navigation with error handling
nnoremap <silent> <C-p> :lua pcall(function() require('telescope.builtin').find_files() end)<CR>
nnoremap <silent> <leader>ff :lua pcall(function() require('telescope.builtin').live_grep() end)<CR>
nnoremap <silent> <leader>fb :lua pcall(function() require('telescope.builtin').buffers() end)<CR>
nnoremap <silent> <leader>fh :lua pcall(function() require('telescope.builtin').help_tags() end)<CR>

" Git navigation
nnoremap <silent> <leader>fg :lua pcall(function() require('telescope.builtin').git_status() end)<CR>
nnoremap <silent> <leader>fc :lua pcall(function() require('telescope.builtin').git_commits() end)<CR>

" Buffer management
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-c> :bdelete<CR>

" Save operations 
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Terminal
nnoremap <silent> <C-o> :FloatermToggle<CR>
tnoremap <silent> <C-o> <C-\><C-n>:FloatermToggle<CR>

" File tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFindFile<CR>

" COC keymaps with error handling
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" COC navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>ca <Plug>(coc-codeaction)

" COC diagnostics
nnoremap <silent> <leader>d :call CocActionAsync('diagnosticInfo')<CR>
nnoremap <silent> <leader>cr :CocRestart<CR>
nnoremap <silent> <leader>cl :CocList diagnostics<CR>

" Manual format commands
nnoremap <silent> <leader>pf :ManualPrettier<CR>
nnoremap <silent> <leader>ef :ManualEslintFix<CR>
nnoremap <silent> <leader>oi :ManualOrganizeImports<CR>

" Git operations
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>ga :Git add .<CR>

" Quick access
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>
nnoremap <leader>/ :nohl<CR>
