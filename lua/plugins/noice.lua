vim.pack.add({
	{ src = "https://github.com/folke/noice.nvim" },
})

local opts = {
	lsp = {
		progress = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	errors = {
		view = "notify",
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
				},
			},
			view = "mini",
		},
	},
	presets = {
		command_palette = true,
		long_message_to_split = true,
		lsp_doc_border = true,
	},
}

local keys = {
	{
		"<c-f>",
		function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-f>"
			end
		end,
		silent = true,
		expr = true,
		desc = "Scroll Backward",
		mode = { "i", "n", "s" },
	},
	{
		"<c-b>",
		function()
			if not require("noice.lsp").scroll(4) then
				return "<c-b>"
			end
		end,
		silent = true,
		expr = true,
		desc = "Scroll Forward",
		mode = { "i", "n", "s" },
	},
}

Utils.setup_keymaps(keys)
require("noice").setup(opts)
