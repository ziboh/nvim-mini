vim.pack.add({
	"https://github.com/TheLeoP/powershell.nvim",
})

Utils.create_autocmd_once("FileType", {
	pattern = "ps1",
	callback = function()
		require("powershell").setup({
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
		})
	end,
})
