vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons" },
	"https://github.com/nvim-mini/mini.hipatterns",
})

Utils.create_autocmd_once({ "BufReadPre", "BufNewFile" }, {
	callback = function()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				-- highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end,
})

package.preload["nvim-web-devicons"] = function()
	require("mini.icons").mock_nvim_web_devicons()
	return package.loaded["nvim-web-devicons"]
end
require("mini.icons").setup({
	file = {
		[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
		["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
		["compose.yaml"] = { glyph = "󰡨", hl = "MiniIconsAzure" },
	},
	filetype = {
		dotenv = { glyph = "", hl = "MiniIconsYellow" },
		yaml = { glyph = "", hl = "MiniIconsPurple" },
		outline = { glyph = "󰱺", hl = "MiniIconsYellow" },
		nu = { glyph = "", hl = "MiniIconsGreen" },
		nushell = { glyph = "", hl = "MiniIconsGreen" },
	},
	lsp = {
		supermaven = { glyph = "", hl = "MiniIconsYellow" },
		fitten = { glyph = "", hl = "MiniIconsYellow" },
		copilot = { glyph = "", hl = "MiniIconsYellow" },
		codeium = { glyph = "", hl = "MiniIconsBlue" },
	},
})
