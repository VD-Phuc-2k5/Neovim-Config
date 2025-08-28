-- formatting.lua
return {
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
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
			-- Custom formatters with 80 char line limit
			formatters = {
				prettier = {
					prepend_args = {
						"--single-quote",
						"--jsx-single-quote",
						"--print-width=80",
					},
				},
				stylua = {
					prepend_args = { "--column-width", "80" },
				},
				clang_format = {
					prepend_args = { "--style={ColumnLimit: 80}" },
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
			-- Manual format command only
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format buffer manually" })
		end,
	},
}
