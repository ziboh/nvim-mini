return {
	name = "Uv list",
	builder = function()
		return {
			cmd = "uv pip list",
		}
	end,
	condition = {
		filetype = { "python" },
	},
}
