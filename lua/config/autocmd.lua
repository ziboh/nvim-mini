vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("FiletypeSpecificTabs", { clear = true }),
	pattern = { "text" },
	callback = function()
		vim.bo.expandtab = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("AutoSetFileType", {}),
	pattern = "json",
	callback = function()
		vim.bo.filetype = "jsonc"
	end,
})

local group = vim.api.nvim_create_augroup("ChangeTitle", { clear = true })
vim.api.nvim_create_autocmd("TermEnter", {
	group = group,
	callback = function()
		vim.opt.titlestring = "terminal"
	end,
})

vim.api.nvim_create_autocmd("TermLeave", {
	group = group,
	callback = function()
		vim.opt.titlestring = "neovim"
	end,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = group,
	pattern = "*",
	callback = function()
		vim.opt.titlestring = "command"
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = group,
	pattern = "*",
	callback = function()
		vim.opt.titlestring = "neovim"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = "snacks_picker_list",
	callback = function(args)
		vim.opt.titlestring = "neovim-explorer"
		Utils.create_autocmd_once("BufLeave", {
			buffer = args.buf,
			group = group,
			callback = function()
				vim.opt.titlestring = "neovim"
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "autohotkey",
	callback = function()
		vim.bo.commentstring = "; %s"
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

local function apply_chezmoi_file()
	local source_dir = vim.fn.trim(vim.fn.system("chezmoi source-path"))
	local buf_path = vim.api.nvim_buf_get_name(0)
	local rel_path = vim.fs.relpath(source_dir, vim.fn.fnamemodify(buf_path, ":p"))
	if buf_path == "" or not rel_path or rel_path:sub(1, 1) == "." then
		return
	end
	-- 转换路径
	rel_path = rel_path:gsub("^dot%_", "."):gsub("%.tmpl$", ""):gsub("/dot%.", "/.")
	local target_path = vim.fs.joinpath(vim.fn.expand("~"), rel_path)

	-- 异步应用
	vim.system({ "chezmoi", "apply", target_path }, { text = true }, function(result)
		if result.code == 0 then
			Snacks.notify("chezmoi apply " .. target_path, { title = "chezmoi" })
		else
			Snacks.notify.error("chezmoi apply error: " .. target_path, { title = "chezmoi" })
		end
	end)
end

-- 自动命令
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = apply_chezmoi_file,
})
