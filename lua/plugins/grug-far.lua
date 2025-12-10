vim.pack.add({
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
})

Utils.create_autocmd_once("BufEnter", {
	callback = function()
		local opts = { headerMaxWidth = 80 }
		local keys = {
			{
				"<leader>r/",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
			{
				"<leader>rw",
				function()
					local path = vim.fn.expand("%")
					local grug = require("grug-far")
					grug.open({
						transient = true,
						prefills = {
							paths = path,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace (Current File)",
			},
		}
		require("grug-far").setup(opts)
		Utils.setup_keymaps(keys)
	end,
})
