vim.pack.add({
	{ src = "https://github.com/mistweaverco/kulala.nvim" },
})

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

Utils.create_autocmd_once("Filetype", {
	pattern = "http",
	callback = function()
		require("kulala").setup()
	end,
})
