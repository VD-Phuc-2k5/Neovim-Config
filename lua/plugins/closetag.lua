-- closetag.lua
return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false
        },
        per_filetype = {
          ["html"] = {
            enable_close = true
          },
          ["jsx"] = {
            enable_close = true
          },
          ["tsx"] = {
            enable_close = true
          },
          ["javascript"] = {
            enable_close = true
          },
          ["typescript"] = {
            enable_close = true
          },
          ["vue"] = {
            enable_close = true
          }
        }
      })
    end,
  },
  {
    "alvan/vim-closetag",
    enabled = false,
    ft = { 'html', 'xhtml', 'phtml', 'jsx', 'tsx', 'javascript', 'typescript', 'vue', 'svelte' },
    config = function()
      vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*.js,*.ts,*.vue,*.svelte'
      vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx,*.js,*.ts'
      vim.g.closetag_filetypes = 'html,xhtml,phtml,jsx,tsx,javascript,typescript,vue,svelte'
      vim.g.closetag_xhtml_filetypes = 'xhtml,jsx,tsx,javascript,typescript'
      vim.g.closetag_emptyTags_caseSensitive = 1
      vim.g.closetag_regions = {
        ['typescript.tsx'] = 'jsxRegion,tsxRegion',
        ['javascript.jsx'] = 'jsxRegion',
        ['typescriptreact'] = 'jsxRegion,tsxRegion',
        ['javascriptreact'] = 'jsxRegion',
      }
      vim.g.closetag_shortcut = '>'
      vim.g.closetag_close_shortcut = '<leader>>'
    end
  }
}
