"====== GIT CONFIGURATION ======
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
" Git commands - vertical split
nnoremap <leader>gs :vertical Git status<CR>
nnoremap <leader>gc :vertical Git commit<CR>
nnoremap <leader>gp :vertical Git push<CR>
nnoremap <leader>gd :vertical Git diff<CR>
nnoremap <leader>ga :Git add .<CR>
nnoremap <leader>cf :Git add %<CR>
nnoremap <leader>re :Git reset HEAD<CR>

" Git log commands - vertical split
nnoremap <leader>l :vertical Git log --oneline<CR>
nnoremap <leader>gl :vertical Git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<CR>
nnoremap <leader>gla :vertical Git log --all --graph --decorate --oneline<CR>
nnoremap <leader>glp :vertical Git log -p<CR>
nnoremap <leader>gls :vertical Git log --stat<CR>

" Git show commit - vertical split
nnoremap <leader>sh :vertical Git show HEAD<CR>
nnoremap <leader>cm :vertical Git show 

" Git branch - vertical split
nnoremap <leader>gb :vertical Git branch<CR>

" Xem commit history của file hiện tại - vertical split
nnoremap <leader>gf :vertical Git log --follow -- %<CR>

" Xem ai đã sửa file này - vertical split
nnoremap <leader>gw :vertical Git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short -- %<CR>

" Commands để xem git log - vertical split
command! GitLog vertical Git log --oneline
command! GitLogGraph vertical Git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
command! GitLogAll vertical Git log --all --graph --decorate --oneline
command! GitLogPatch vertical Git log -p
command! GitLogStat vertical Git log --stat
