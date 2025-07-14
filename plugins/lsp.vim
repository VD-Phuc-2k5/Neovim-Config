" ====== COC CONFIGURATION ======
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-go',
  \ 'coc-omnisharp',
  \ 'coc-clangd',
  \ ]

" Block coc-import-cost
autocmd VimEnter * silent! call coc#util#uninstall_extension('coc-import-cost')
let g:coc_user_config = {'import-cost.enable': v:false}

" Format on save (non-Go files)
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.json,*.cs,*.cpp,*.cc,*.cxx,*.c,*.h,*.hpp silent! call CocAction('format')

" Auto organize imports
autocmd BufWritePre *.ts,*.tsx,*.cs,*.cpp,*.cc,*.cxx,*.c,*.h,*.hpp call CocAction('runCommand', 'editor.action.organizeImport')

" OmniSharp Configuration
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_timeout = 5
let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}

" ALE Configuration for C#, C++
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'cpp': ['clangd', 'cppcheck'],
\ 'c': ['clangd', 'cppcheck']
\}

" Disable ALE for other languages (use COC instead)
let g:ale_linters_explicit = 1

" C++ LSP specific settings
autocmd FileType cpp,c setlocal omnifunc=CocComplete
autocmd FileType cpp,c nnoremap <buffer> <silent> gd <Plug>(coc-definition)
autocmd FileType cpp,c nnoremap <buffer> <silent> gy <Plug>(coc-type-definition)
autocmd FileType cpp,c nnoremap <buffer> <silent> gi <Plug>(coc-implementation)
autocmd FileType cpp,c nnoremap <buffer> <silent> gr <Plug>(coc-references)
autocmd FileType cpp,c nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
autocmd FileType cpp,c nnoremap <buffer> <silent> <leader>rn <Plug>(coc-rename)

lua <<EOF
-- Cấu hình autopairs
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'},
    cs = {'string', 'comment'},
    cpp = {'string', 'comment'},
    c = {'string', 'comment'}
  }
})

-- Thêm rule cho HTML/JSX và C#
npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function(opts)
      return vim.tbl_contains({'text', 'html', 'cs'}, vim.bo.filetype)
    end)
    :with_move(function() return true end)
    :with_cr(function() return false end),
    
  -- C# specific rules
  Rule('{', '}')
    :with_pair(function(opts)
      return vim.bo.filetype == 'cs'
    end)
})

-- Thêm rule cho HTML/JSX, C# và C++
npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function(opts)
      return vim.tbl_contains({'text', 'html', 'cs', 'cpp', 'c'}, vim.bo.filetype)
    end)
    :with_move(function() return true end)
    :with_cr(function() return false end),
    
  -- C# specific rules
  Rule('{', '}')
    :with_pair(function(opts)
      return vim.bo.filetype == 'cs'
    end)
})

-- Tích hợp autopairs với completion
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
EOF
