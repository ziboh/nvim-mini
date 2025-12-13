vim.pack.add({
	"https://github.com/linux-cultist/venv-selector.nvim",
})

require("venv-selector").setup({})
local opts = {
	servers = {
		ruff = {
			cmd_env = { RUFF_TRACE = "messages" },
			init_options = {
				settings = {
					logLevel = "error",
				},
			},
		},
		pyright = { enabled = true },
	},
	setup = {
		ruff = function()
			Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
				client.server_capabilities.hoverProvider = false
			end)
		end,
	},
}

local keys = {
	{
		"<leader>pr",
		function()
			vim.schedule(function()
				local file_path = vim.fn.expand("%:p")
				local win = Snacks.win({
					width = 0.4,
					height = 0.4,
					position = "bottom",
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
				vim.cmd("term " .. "uv run " .. file_path)
				vim.bo[win.buf].buflisted = false
				win:map()
			end)
		end,
		desc = "uv run",
		silent = true,
		expr = true,
	},
}
Utils.setup_keymaps(keys)

return opts
