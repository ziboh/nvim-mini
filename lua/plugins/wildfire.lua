vim.pack.add({
	{ src = "https://github.com/sustech-data/wildfire.nvim" },
})

Utils.create_autocmd_once("FileType", {
	callback = function()
		require("wildfire").setup({
			surrounds = {
				{ "(", ")" },
				{ "{", "}" },
				{ "<", ">" },
				{ "[", "]" },
			},
			filetype_exclude = { "qf", "outline" }, --keymaps will be unset in excluding filetypes
		})
	end,
})
