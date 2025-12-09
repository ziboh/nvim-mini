vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
Utils.create_autocmd_once("Filetype", {
	callback = function()
		local opts = {
			ensure_installed = {},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		}
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup(opts)
	end,
})
