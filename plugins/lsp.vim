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
  \ ]

" Block coc-import-cost
autocmd VimEnter * silent! call coc#util#uninstall_extension('coc-import-cost')
let g:coc_user_config = {'import-cost.enable': v:false}

" Format on save (non-Go files)
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.json,*.cs silent! call CocAction('format')

" Auto organize imports
autocmd BufWritePre *.ts,*.tsx,*.cs call CocAction('runCommand', 'editor.action.organizeImport')

" OmniSharp Configuration
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_timeout = 5
let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}

" ALE Configuration for C#
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" Disable ALE for other languages (use COC instead)
let g:ale_linters_explicit = 1

lua <<EOF
-- Cấu hình autopairs
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'},
    cs = {'string', 'comment'}
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

-- Tích hợp autopairs với completion
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
EOF
