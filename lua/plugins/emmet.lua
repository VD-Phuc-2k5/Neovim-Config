-- emmet.lua
return {
	{
		"mattn/emmet-vim",
		ft = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
		config = function()
			vim.g.user_emmet_install_global = 1
			vim.g.user_emmet_leader_key = '<C-y>'
			vim.g.user_emmet_mode = 'a'
			vim.g.user_emmet_expandabbr_key = '<CR>'
			vim.g.user_emmet_settings = {
				html = {
					default_attributes = {
						option = { value = nil },
						textarea = { id = nil, name = nil, cols = 10, rows = 10 },
					},
					snippets = {
						html = '<!DOCTYPE html>\n'
							.. '<html lang="${lang}">\n'
							.. '<head>\n'
							.. '\t<meta charset="${charset}">\n'
							.. '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
							.. '\t<title></title>\n'
							.. '</head>\n'
							.. '<body>\n'
							.. '\t${child}|\n'
							.. '</body>\n'
							.. '</html>',
					},
				},
			}
		end,
		keys = {
			{ "<C-y>,", "<Plug>(emmet-expand-abbr)", mode = "i", ft = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" } },
			{ "<C-y>,", "<Plug>(emmet-expand-abbr)", mode = "v", ft = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" } },
			{ "<CR>", "<Plug>(emmet-expand-abbr)", mode = "i", ft = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" }, desc = "Emmet expand with Enter" },
		},
		init = function()
			vim.g.user_emmet_settings = vim.tbl_deep_extend("force", vim.g.user_emmet_settings or {}, {
				javascript = {
					extends = 'jsx',
				},
				typescript = {
					extends = 'tsx',
				},
			})
		end,
	},
}
