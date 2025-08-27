-- git.lua
return {
  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>gb', function()
          gs.blame_line { full = false }
        end, { buffer = bufnr, desc = 'Git blame line' })
        vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr, desc = 'Git diff against index' })
        vim.keymap.set('n', '<leader>gD', function()
          gs.diffthis '~'
        end, { buffer = bufnr, desc = 'Git diff against last commit' })
        -- Navigation
        vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Next hunk' })
        vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Previous hunk' })
        -- Actions
        vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
        vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { buffer = bufnr, desc = 'Reset hunk' })
      end,
    },
  },

  -- Git commands
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gP', ':Git push<CR>', { desc = 'Git push' })
      vim.keymap.set('n', '<leader>gl', ':Git log<CR>', { desc = 'Git log' })
      vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>', { desc = 'Git fetch' })
      vim.keymap.set('n', '<leader>gu', ':Git pull<CR>', { desc = 'Git pull' })
    end,
  },
}
