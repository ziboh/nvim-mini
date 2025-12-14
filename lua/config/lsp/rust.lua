vim.pack.add({
	"https://github.com/saecki/crates.nvim",
	"https://github.com/mrcjkb/rustaceanvim",
})

Utils.create_autocmd_once("FileType", {
	pattern = "rust",
	callback = function()
		local opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>la", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "Rust Debuggables", buffer = bufnr })
					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, { desc = "Rust Hover", buffer = bufnr })
				end,
				offset_encoding = "utf-8",
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- Add clippy lints for Rust if using rust-analyzer
						checkOnSave = diagnostics == "rust-analyzer",
						-- Enable diagnostics if using rust-analyzer
						diagnostics = {
							enable = diagnostics == "rust-analyzer",
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
						files = {
							excludeDirs = {
								".direnv",
								".git",
								".github",
								".gitlab",
								"bin",
								"node_modules",
								"target",
								"venv",
								".venv",
							},
						},
					},
				},
			},
			status_notify_level = false,
		}
		local capabilities = require("rustaceanvim.config.server").create_client_capabilities()
		capabilities.general.positionEncodings = { "utf-8", "utf-16" }
		opts.server.capabilities = capabilities
		vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		if vim.fn.executable("rust-analyzer") == 0 then
			Snacks.notify.error(
				"**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
				{ title = "rustaceanvim" }
			)
		end
	end,
})

local filepath = vim.api.nvim_buf_get_name(0)
local basename = vim.fn.fnamemodify(filepath, ":t")
local crates_loaded = false
if basename == "Cargo.toml" then
	require("crates").setup({
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
			hover = true,
		},
	})
	crates_loaded = true
end

Utils.create_autocmd_once("BufReadPre", {
	pattern = "Cargo.toml",
	callback = function()
		if crates_loaded == true then
			return
		end
		require("crates").setup({
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		})
	end,
})

return {
	server = {
		["crates.nvim"] = {
			keys = {
				{
					"<leader>h",
					function()
						local filetype = vim.bo.filetype
						if filetype == "vim" or filetype == "help" then
							vim.cmd("h " .. vim.fn.expand("<cword>"))
						elseif filetype == "man" then
							vim.cmd("Man " .. vim.fn.expand("<cword>"))
						elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
							require("crates").show_popup()
						else
							vim.lsp.buf.hover()
						end
					end,
					desc = "Hover",
				},
				{
					"K",
					function()
						local filetype = vim.bo.filetype
						if filetype == "vim" or filetype == "help" then
							vim.cmd("h " .. vim.fn.expand("<cword>"))
						elseif filetype == "man" then
							vim.cmd("Man " .. vim.fn.expand("<cword>"))
						elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
							require("crates").show_popup()
						else
							vim.lsp.buf.hover()
						end
					end,
					desc = "Hover",
				},
			},
		},
	},
}
