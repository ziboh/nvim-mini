if Utils.is_remote() then
	vim.pack.add({
		{ src = "https://github.com/ojroques/nvim-osc52" },
	})

	require("osc52").setup()

	local function copy(lines, _)
		require("osc52").copy(table.concat(lines, "\n"))
	end

	local function paste()
		return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
	end

	vim.g.clipboard = {
		name = "osc52",
		copy = { ["+"] = copy, ["*"] = copy },
		paste = { ["+"] = paste, ["*"] = paste },
	}
end
