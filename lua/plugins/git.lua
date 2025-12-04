vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/esmuellert/vscode-diff.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
})

require("vscode-diff").setup()
require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	signs_staged = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
	},
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
		end

      -- stylua: ignore start
      map("n", "]g", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next",{target = 'all'})
        end
      end, "Next Hunk")
      map("n", "[g", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev",{target = 'all'})
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	end,
})

-- 设置 <leader>ga - 添加当前文件到暂存区
vim.keymap.set("n", "<leader>ga", function()
	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("No file in buffer", vim.log.levels.WARN)
		return
	end

	-- 检查是否在 git 仓库中
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir == "" then
		vim.notify("Not in a git repository", vim.log.levels.WARN)
		return
	end

	-- 获取文件状态
	local status = vim.fn.system("git status --porcelain " .. vim.fn.shellescape(file))
	local is_staged = status:match("^M ") or status:match("^A ")
	local is_modified = status:match("^ M") or status:match("^AM") or status:match("^MM")

	if not is_modified and not is_staged then
		vim.notify("File has no changes", vim.log.levels.WARN)
		return
	end

	if is_staged then
		vim.notify("File already in staging area", vim.log.levels.WARN)
		return
	end

	-- 添加文件到暂存区
	vim.fn.system("git add " .. vim.fn.shellescape(file))
	if vim.v.shell_error == 0 then
		vim.notify("File added to staging area")
	else
		vim.notify("Failed to add file", vim.log.levels.ERROR)
	end
end, { desc = "Git add current file" })

-- 设置 <leader>gA - 添加所有修改的文件
vim.keymap.set("n", "<leader>gA", function()
	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("No file in buffer", vim.log.levels.WARN)
		return
	end

	-- 检查是否在 git 仓库中
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir == "" then
		vim.notify("Not in a git repository", vim.log.levels.WARN)
		return
	end

	-- 获取当前文件状态
	local current_status = vim.fn.system("git status --porcelain " .. vim.fn.shellescape(file))
	local current_is_staged = current_status:match("^M ") or current_status:match("^A ")

	-- 获取所有修改的文件
	local all_changes = vim.fn.system("git status --porcelain")
	if all_changes == "" then
		vim.notify("No changes to stage", vim.log.levels.WARN)
		return
	end

	-- 添加所有修改的文件
	vim.fn.system("git add -u")
	if vim.v.shell_error == 0 then
		vim.notify("All changes staged")
	else
		vim.notify("Failed to stage changes", vim.log.levels.ERROR)
	end
end, { desc = "Git add all changes" })
