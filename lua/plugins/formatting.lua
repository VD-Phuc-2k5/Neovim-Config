-- formatting.lua
return {
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = true,
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
			vim.keymap.set("n", "<leader>f", function()
				local conform = require("conform")
				conform.format({ 
					async = true, 
					lsp_fallback = true,
					timeout_ms = 1000,
				}, function(err)
					if err then
						vim.notify("Format error: " .. tostring(err), vim.log.levels.ERROR)
					else
						vim.notify("Formatted successfully", vim.log.levels.INFO)
					end
				end)
			end, { desc = "Format buffer manually" })
			vim.keymap.set("n", "<leader>cf", function()
				local conform = require("conform")
				local formatters = conform.list_formatters(0)
				if #formatters == 0 then
					vim.notify("No formatters available for this filetype", vim.log.levels.WARN)
				else
					local formatter_names = {}
					for _, formatter in ipairs(formatters) do
						table.insert(formatter_names, formatter.name)
					end
					vim.notify("Available formatters: " .. table.concat(formatter_names, ", "), vim.log.levels.INFO)
				end
			end, { desc = "Check available formatters" })
		end,
	},
}
