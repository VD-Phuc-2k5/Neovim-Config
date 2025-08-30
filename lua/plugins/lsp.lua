return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- JavaScript/TypeScript
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        -- C#
        "omnisharp",
        "csharpier",
        -- Go
        "gopls",
        "goimports",
        "golangci-lint",
      },
    },
  },
}
