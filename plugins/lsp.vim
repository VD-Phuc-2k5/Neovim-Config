" ====== COC CONFIGURATION ======
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-go',
  \ ]

" Block coc-import-cost
autocmd VimEnter * silent! call coc#util#uninstall_extension('coc-import-cost')
let g:coc_user_config = {'import-cost.enable': v:false}

" Format on save (non-Go files)
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.json silent! call CocAction('format')

" Auto organize imports
autocmd BufWritePre *.ts,*.tsx call CocAction('runCommand', 'editor.action.organizeImport')

lua <<EOF
-- Cấu hình autopairs
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'}, 
  }
})

npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function(opts)
      return vim.tbl_contains({'text', 'html'}, vim.bo.filetype)
    end)
    :with_move(function() return true end)
    :with_cr(function() return false end),  
})

-- autopairs với completion
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
EOF
