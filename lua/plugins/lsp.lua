-- lsp.lua
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			-- Setup Mason
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"clangd",
					"omnisharp",
					"cssls",
					"html",
					"eslint",
					"jsonls",
				},
			})

			-- Setup neodev for better lua development
			require("neodev").setup()
			-- Setup fidget for LSP status
			require("fidget").setup()

			-- LSP attach function
			local on_attach = function(client, bufnr)
				-- Disable automatic formatting (only format on :Format command)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- Manual format command only
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })
			end

			-- Setup capabilities for nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- LSP server configurations
			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
				gopls = {
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				omnisharp = {
					cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
					settings = {
						FormattingOptions = {
							EnableEditorConfigSupport = true,
							OrganizeImports = nil,
						},
						MsBuild = {
							LoadProjectsOnDemand = nil,
						},
						RoslynExtensionsOptions = {
							EnableAnalyzersSupport = nil,
							EnableImportCompletion = nil,
							AnalyzeOpenDocumentsOnly = nil,
						},
					},
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						client.server_capabilities.semanticTokensProvider = {
							full = true,
							legend = {
								tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator" },
								tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
							},
							range = true,
						}
					end,
				},
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				cssls = {},
				html = {},
				eslint = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
								-- Suppress undefined global warnings
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
							telemetry = { enable = false },
							hint = {
								enable = true,
							},
							diagnostics = {
								-- Suppress vim global warnings
								globals = { "vim" },
							},
						},
					},
				},
			}

			-- Setup each LSP server individually
			for server_name, server_config in pairs(servers) do
				local setup_config = {
					capabilities = capabilities,
					on_attach = server_config.on_attach or on_attach,
					settings = server_config.settings,
					filetypes = server_config.filetypes,
					cmd = server_config.cmd,
					init_options = server_config.init_options,
				}

				require("lspconfig")[server_name].setup(setup_config)
			end
		end,
	},
}
