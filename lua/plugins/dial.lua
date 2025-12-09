vim.pack.add({
	{ src = "https://github.com/monaqa/dial.nvim" },
})

Utils.create_autocmd_once("BufEnter", {
	callback = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.alias.bool,
				augend.semver.alias.semver,
				augend.date.new({
					pattern = "%B", -- titlecased month names
					default_kind = "day",
				}),
				augend.constant.new({
					elements = {
						"january",
						"february",
						"march",
						"april",
						"may",
						"june",
						"july",
						"august",
						"september",
						"october",
						"november",
						"december",
					},
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = {
						"Monday",
						"Tuesday",
						"Wednesday",
						"Thursday",
						"Friday",
						"Saturday",
						"Sunday",
					},
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = {
						"monday",
						"tuesday",
						"wednesday",
						"thursday",
						"friday",
						"saturday",
						"sunday",
					},
					word = true,
					cyclic = true,
				}),
				augend.case.new({
					types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
				}),
			},
		})
		local keys = {
			{
				"<c-a>",
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				desc = "Increment under cursor",
			},
			{
				"<C-x>",
				function()
					require("dial.map").manipulate("decrement", "normal")
				end,
				desc = "Decrement under cursor",
			},
			{
				"g<C-a>",
				function()
					require("dial.map").manipulate("increment", "gnormal")
				end,
				desc = "Increment globally under cursor",
			},
			{
				"g<C-x>",
				function()
					require("dial.map").manipulate("decrement", "gnormal")
				end,
				desc = "Decrement globally under cursor",
			},
			{
				"<C-a>",
				function()
					require("dial.map").manipulate("increment", "visual")
				end,
				mode = "v",
				desc = "Increment in visual mode",
			},
			{
				"<c-x>",
				function()
					require("dial.map").manipulate("decrement", "visual")
				end,
				mode = "v",
				desc = "Decrement in visual mode",
			},
			{
				"g<C-a>",
				function()
					require("dial.map").manipulate("increment", "gvisual")
				end,
				mode = "v",
				desc = "Increment globally in visual mode",
			},
			{
				"g<C-x>",
				function()
					require("dial.map").manipulate("decrement", "gvisual")
				end,
				mode = "v",
				desc = "Decrement globally in visual mode",
			},
		}
		Utils.setup_keymaps(keys)
	end,
})
