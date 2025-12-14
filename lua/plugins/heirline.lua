vim.pack.add({
	{ src = "https://github.com/rebelot/heirline.nvim" },
})

Utils.create_autocmd_once("UIEnter", {
	group = vim.api.nvim_create_augroup("SetupHeirline", { clear = true }),
	callback = function()
		vim.opt.laststatus = 3
		require("heirline").setup({
			statusline = require("config.heirline.statusline"),
		})
	end,
})
