vim.pack.add({
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

local opts = {
	file_types = { "markdown", "Avante" },
	quote = { repeat_linebreak = true },
	win_options = {
		showbreak = { default = "", rendered = "  " },
		breakindent = { default = false, rendered = true },
		breakindentopt = { default = "", rendered = "" },
	},
}

require("render-markdown").setup(opts)

Snacks.toggle({
	name = "Render Markdown",
	get = function()
		return require("render-markdown.state").enabled
	end,
	set = function(enabled)
		local m = require("render-markdown")
		if enabled then
			m.enable()
		else
			m.disable()
		end
	end,
}):map("<leader>um")
