vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround" },
})
Utils.create_autocmd_once("BufEnter", {
	callback = function()
		local surround = require("nvim-surround")
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
})
