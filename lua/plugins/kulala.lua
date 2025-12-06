vim.pack.add({
	{ src = "https://github.com/mistweaverco/kulala.nvim" },
})

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

require("kulala").setup()
