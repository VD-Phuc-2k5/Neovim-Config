-- formatting.lua
return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        go = { "gofmt" },
        cpp = { "clang_format" },
        c = { "clang_format" },
      },
      -- Custom formatters
      formatters = {
        prettier = {
          prepend_args = { "--single-quote", "--jsx-single-quote" },
        },
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)
      -- Format command
      vim.keymap.set('n', '<leader>f', function()
        require('conform').format({ async = true, lsp_fallback = true })
      end, { desc = 'Format buffer' })
    end,
  },
}
