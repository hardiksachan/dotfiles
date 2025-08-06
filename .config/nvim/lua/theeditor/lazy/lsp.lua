return {
	"neovim/nvim-lspconfig",
	event = { "VeryLazy" },
	dependencies = {
		-- vim completions
		"folke/neodev.nvim",
		-- lsp server manager
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- mini ui of progress on right
		"j-hui/fidget.nvim",
		-- autoformatting
		"stevearc/conform.nvim",
		-- json schema information
		"b0o/SchemaStore.nvim",
	},
	opts = {
		inlay_hints = { enabled = true },
	},
	config = function()
		require("neodev").setup()

		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
		end

		local lspconfig = require("lspconfig")

		local servers = {
			bashls = true,
			pyright = {
				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
							useLibraryCodeForTypes = true,
							typeCheckingMode = "basic",
						},
					},
				},
			},
			ruff = {},
			gopls = {
				settings = {
					gopls = {
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
			lua_ls = {
				server_capabilities = {
					semanticTokensProvider = vim.NIL,
				},
			},
			rust_analyzer = true,
			svelte = true,
			templ = true,
			cssls = {
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			},

			-- Modern TypeScript/JavaScript support
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
					javascript = {
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

			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},

			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			},

			clangd = {
				server_capabilities = {
					signatureHelpProvider = false,
				},
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
				settings = {
					clangd = {
						arguments = {
							"--background-index",
							"--clang-tidy",
							"--header-insertion=iwyu",
							"--completion-style=detailed",
							"--fallback-style=Google",
						},
					},
				},
			},
			neocmake = {},

			zls = {
				cmd = { "zls" },
				filetypes = { "zig", "zon" },
			},

			-- HTML support
			html = {
				settings = {
					html = {
						format = {
							templating = true,
							wrapLineLength = 120,
							wrapAttributes = "auto",
						},
					},
				},
			},

			-- Docker support
			dockerls = {},

			-- Markdown support
			marksman = {},

			-- SQL support
			sqlls = {},

			-- Shell script support (bashls is already configured above)
		}

		local servers_to_install = vim.tbl_filter(function(key)
			local t = servers[key]
			if type(t) == "table" then
				return not t.manual_install
			else
				return t
			end
		end, vim.tbl_keys(servers))

		require("mason").setup()
		local ensure_installed = {
			-- Formatters
			"stylua",
			"black",
			"prettier",
			"clang_format",
			"zig",
			
			-- Linters
			"ruff",
			"cmakelang",
			"cmakelint",
			"shellcheck",
			
			-- LSP Servers
			"lua_ls",
			"typescript-language-server",
			"pyright",
			"gopls",
			"rust_analyzer",
			"clangd",
			"zls",
			"templ",
			"svelte",
			"cssls",
			"html",
			"jsonls",
			"yamlls",
			"dockerls",
			"marksman",
			"sqlls",
			
			-- Debuggers
			"delve",
			"codelldb",
		}

		vim.list_extend(ensure_installed, servers_to_install)
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, config in pairs(servers) do
			if config == true then
				config = {}
			end
			config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)

			lspconfig[name].setup(config)
		end

		local disable_semantic_tokens = {
			lua = true,
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

				local settings = servers[client.name]
				if type(settings) ~= "table" then
					settings = {}
				end

				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
				
				-- LSP keymaps (buffer-local for LSP-enabled buffers)
				-- These work alongside Snacks' global keymaps
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to definition" })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to declaration" })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "Show references" })
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0, desc = "Go to implementation" })
				vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to type definition" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Show hover" })
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc = "Rename symbol" })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code action" })

				local filetype = vim.bo[bufnr].filetype
				if disable_semantic_tokens[filetype] then
					client.server_capabilities.semanticTokensProvider = nil
				end

				-- Override server capabilities
				if settings.server_capabilities then
					for k, v in pairs(settings.server_capabilities) do
						if v == vim.NIL then
							---@diagnostic disable-next-line: cast-local-type
							v = nil
						end

						client.server_capabilities[k] = v
					end
				end
			end,
		})

		-- Autoformatting Setup
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				zig = { "zig fmt" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				vim.schedule(function()
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						async = true, -- Ensures asynchronous formatting
						quiet = true,
					})
				end)
			end,
		})
	end,
}
