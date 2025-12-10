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
