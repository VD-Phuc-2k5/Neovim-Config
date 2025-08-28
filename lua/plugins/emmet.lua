-- emmet.lua
return {
	{
		"mattn/emmet-vim",
		ft = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
		config = function()
			vim.g.user_emmet_install_global = 0
			vim.g.user_emmet_leader_key = '<Tab>'
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
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
				callback = function()
					vim.cmd("EmmetInstall")
				end,
			})
		end,
	},
}
