local exec_table = {
	autohotkey = {
		bin = { "autohotkey" },
	},
	python = {
		bin = { "uv", "run" },
	},
}

local enabled_filetype = {}

for ft, cmd in pairs(exec_table) do
	if vim.fn.executable(cmd.bin[1]) == 1 then
		table.insert(enabled_filetype, ft)
	end
end

return {
	name = "Run current file",
	builder = function()
		local current_file = vim.fn.expand("%:p")
		local filetype = vim.bo.filetype
		local bin = vim.deepcopy(exec_table[filetype].bin)
		table.insert(bin, current_file)
		return {
			cmd = bin,
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = enabled_filetype,
	},
}
