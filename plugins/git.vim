" ====== GIT CONFIGURATION ======
lua <<EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = '≈' },
    untracked    = { text = '?' },
  },
  signcolumn = true,
  numhl      = false,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  max_file_length = 40000,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation giữa các hunks
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true, desc = 'Next hunk'})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true, desc = 'Previous hunk'})

    -- Git actions
    map('n', '<leader>hs', gs.stage_hunk, {desc = 'Stage hunk'})
    map('n', '<leader>hr', gs.reset_hunk, {desc = 'Reset hunk'})
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'Stage hunk'})
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'Reset hunk'})
    map('n', '<leader>hS', gs.stage_buffer, {desc = 'Stage buffer'})
    map('n', '<leader>hu', gs.undo_stage_hunk, {desc = 'Undo stage hunk'})
    map('n', '<leader>hR', gs.reset_buffer, {desc = 'Reset buffer'})
    map('n', '<leader>hp', gs.preview_hunk, {desc = 'Preview hunk'})
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = 'Blame line'})
    map('n', '<leader>tb', gs.toggle_current_line_blame, {desc = 'Toggle blame'})
    map('n', '<leader>hd', gs.diffthis, {desc = 'Diff this'})
    map('n', '<leader>hD', function() gs.diffthis('~') end, {desc = 'Diff this ~'})
    map('n', '<leader>td', gs.toggle_deleted, {desc = 'Toggle deleted'})

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = 'Select hunk'})
  end
}
EOF

" ====== VIM SCRIPT KEY MAPPINGS ======
" Git commands
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gd :Git diff<CR>

" Git log commands
nnoremap <leader>l :Git log --oneline<CR>
nnoremap <leader>gl :Git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<CR>
nnoremap <leader>gla :Git log --all --graph --decorate --oneline<CR>
nnoremap <leader>glp :Git log -p<CR>
nnoremap <leader>gls :Git log --stat<CR>

" Git show commit
nnoremap <leader>gsh :Git show HEAD<CR>
nnoremap <leader>gsc :Git show 

" Git branch
nnoremap <leader>gb :Git branch<CR>
nnoremap <leader>gco :Git checkout 
nnoremap <leader>gcb :Git checkout -b 

" Toggle git blame cho dòng hiện tại
nnoremap <leader>gtb :lua require('gitsigns').blame_line{full=true}<CR>

" Xem commit history của file hiện tại
nnoremap <leader>gf :Git log --follow -- %<CR>

" Xem ai đã sửa file này
nnoremap <leader>gw :Git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short -- %<CR>

" Commands để toggle các tính năng
command! GitSignsToggle lua require('gitsigns').toggle_signs()
command! GitBlameToggle lua require('gitsigns').toggle_current_line_blame()
command! GitNumHlToggle lua require('gitsigns').toggle_numhl()
command! GitLineHlToggle lua require('gitsigns').toggle_linehl()

" Commands để xem git log
command! GitLog Git log --oneline
command! GitLogGraph Git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
command! GitLogAll Git log --all --graph --decorate --oneline
command! GitLogPatch Git log -p
command! GitLogStat Git log --stat
