" ====== KEY MAPPINGS ======
let mapleader = " "

" Navigation
nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" Git navigation with Telescope
nnoremap <leader>fg :Telescope git_status<CR>
nnoremap <leader>fc :Telescope git_commits<CR>

" Buffer management with visual feedback
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-c> :bdelete<CR>

" Save with confirmation
nnoremap <C-s> :w<CR>:echo "File saved!"<CR>
inoremap <C-s> <Esc>:w<CR>:echo "File saved!"<CR>a

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

" Enhanced COC error handling
nnoremap <silent> <leader>cr :CocRestart<CR>:echo "COC restarted!"<CR>
nnoremap <silent> <leader>cl :CocList diagnostics<CR>

" COC completion helper function
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" COC completion mappings with better handling
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() 
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" C# specific global keymaps with better prompts
nnoremap <leader>cs :call CreateProject('console')<CR>
nnoremap <leader>cw :call CreateProject('web')<CR>
nnoremap <leader>cm :call CreateProject('mvc')<CR>

function! CreateProject(type)
  let name = input('Project name: ')
  if !empty(name)
    if a:type == 'console'
      execute '!dotnet new console -n ' . name
    elseif a:type == 'web'
      execute '!dotnet new web -n ' . name
    elseif a:type == 'mvc'
      execute '!dotnet new mvc -n ' . name
    endif
    echo "\nProject '" . name . "' created!"
  else
    echo "Project creation cancelled"
  endif
endfunction

" NvimTree mappings with feedback
nnoremap <C-f> :NvimTreeToggle<CR>
nnoremap <C-n> :NvimTreeFindFile<CR>

" Enhanced file tree operations
nnoremap <leader>nf :NvimTreeFocus<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>:echo "File tree refreshed!"<CR>

" Git mappings
nnoremap <C-d> :Gdiff<CR>

" Toggle line numbers and relative numbers
nnoremap <leader>ln :set number!<CR>
nnoremap <leader>lr :set relativenumber!<CR>

" Quick access to vimrc
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>:echo "Vimrc reloaded!"<CR>

" Clear search highlighting
nnoremap <leader>/ :nohl<CR>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
