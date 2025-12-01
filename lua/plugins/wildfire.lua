vim.pack.add({
	{ src = "https://github.com/sustech-data/wildfire.nvim" },
})

require("wildfire").setup({
	surrounds = {
		{ "(", ")" },
		{ "{", "}" },
		{ "<", ">" },
		{ "[", "]" },
	},
	filetype_exclude = { "qf", "outline" }, --keymaps will be unset in excluding filetypes
})
