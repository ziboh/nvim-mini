vim.pack.add({
	"https://github.com/windwp/nvim-autopairs",
})
Utils.create_autocmd_once("InsertEnter", {
	callback = function()
		require("nvim-autopairs").setup()
	end,
})
