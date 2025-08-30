return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = false,
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
        cs = { "csharpier" },
        go = { "goimports", "gofmt" },
      },
      formatters = {
        prettier = {
          options = {
            ft_parsers = {
              javascript = "babel",
              typescript = "typescript",
            },
            ext_parsers = {
              [".js"] = "babel",
              [".ts"] = "typescript",
            },
          },
          args = { "--print-width", "80", "--stdin-filepath", "$FILENAME" },
        },
      },
    },
  },
}
