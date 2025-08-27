-- editing.lua
return {
  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },

  -- Comment toggle
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Multi-cursor
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- Better quickfix
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf'
  },
}
