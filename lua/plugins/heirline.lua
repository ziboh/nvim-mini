vim.pack.add({
	{ src = "https://github.com/rebelot/heirline.nvim" },
})

local heirline_loaded = false
Utils.create_autocmd_once({ "BufReadPre", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("SetupHeirline", { clear = true }),
	callback = function()
		if heirline_loaded then
			return
		end
		heirline_loaded = true
		require("heirline").setup({
			statusline = require("config.heirline.statusline"),
		})
	end,
})
