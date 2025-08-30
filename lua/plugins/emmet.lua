return {
  {
    "aca/emmet-ls",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.emmet_ls.setup({
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
          "vue",
          "svelte",
        },
      })
    end,
  },
}
