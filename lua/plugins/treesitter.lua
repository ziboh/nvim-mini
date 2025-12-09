vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
Utils.create_autocmd_once("Filetype", {
	callback = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
})
