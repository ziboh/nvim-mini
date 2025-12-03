-- 此文件由 plugins.core 自动加载

-- 基础设置
vim.g.mapleader = " " -- 设置全局映射前导键为空格
vim.g.maplocalleader = "\\" -- 设置局部映射前导键为反斜杠

-- Rime 输入法设置
vim.g.rime_enabled = false -- 是否启用 Rime 输入法支持
-- 禁用 Rime 的模式匹配规则
vim.g.disable_rime_ls_pattern = {
	-- 在 `` 中禁用
	"`(.*)`",
	-- 在 '' 中禁用
	"'(.*)'",
	-- 在 "" 中禁用
	'"(.*)"',
	-- 在 [] 中禁用
	"%[.*%]",
}

-- AI 相关设置
vim.g.supermaven_enabled = false -- 是否启用 SuperMaven AI 补全
vim.g.ai_cmp = true -- 是否启用 AI 补全功能

-- 图标显示设置
vim.g.icons_enabled = true -- 是否启用图标显示

-- Git 工作树配置
vim.g.git_worktrees = {
	{
		toplevel = vim.env.HOME,
		gitdir = vim.env.HOME .. "/.local/share/yadm/repo.git",
	},
}

-- nvim-tree 插件设置
-- 在 init.lua 开始时禁用 netrw（强烈建议）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 外观设置
vim.g.transparent_enabled = false -- 是否启用透明背景

-- Rust Analyzer 设置
vim.g.rust_analyzer_mason = true -- 是否使用 Mason 安装 rust-analyzer

-- 状态栏设置
vim.g.statusline = "heirline" -- 设置状态栏插件，可选："heirline" 或 "lualine"

-- Suda 插件配置
vim.g.suda_smart_edit = 1
vim.g.suda_noninteractive = 1

-- Neovim 选项配置
local opt = vim.opt

-- 命令行设置
opt.cmdheight = 0 -- 命令行高度设置为 0，使用 popup 窗口显示命令行

-- 文件操作设置
opt.autowrite = true -- 自动写入文件
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } -- 会话选项配置
opt.undofile = true -- 启用撤销文件功能
opt.swapfile = false -- 关闭交换文件

-- 界面显示设置
opt.laststatus = 3 -- 全局状态栏
opt.showmode = false -- 不显示当前模式提示（如 --INSERT--）
opt.termguicolors = true -- 启用终端真彩色支持
opt.cursorline = true -- 高亮光标所在行
opt.number = true -- 显示绝对行号
opt.relativenumber = true -- 显示相对行号
opt.showtabline = 2 -- 总是显示标签栏
opt.signcolumn = "yes" -- 总是显示标志列
opt.wrap = true -- 默认自动换行
opt.breakat = "" -- 设置换行字符
opt.fillchars = { -- 设置填充字符
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- 分割窗口设置
opt.splitbelow = true -- 新的水平分割窗口出现在下方
opt.splitright = true -- 新的垂直分割窗口出现在右侧

-- 搜索设置
opt.incsearch = true -- 输入时实时搜索
opt.hlsearch = false -- 不高亮搜索结果
opt.ignorecase = true -- 默认忽略大小写搜索
opt.smartcase = true -- 如果有大写字母则区分大小写
opt.grepprg = "rg --vimgrep" -- 使用 ripgrep 作为默认搜索程序

-- 缩进和制表符设置
opt.tabstop = 4 -- 制表符显示宽度为 4 个空格
opt.softtabstop = 4 -- 编辑时制表符对应的空格数
opt.shiftwidth = 4 -- 每次缩进使用的空格数
opt.expandtab = true -- 将制表符转换为空格，主要用于 Python

-- 滚动设置
opt.scrolloff = 10 -- 滚动时保持至少 10 行可见
opt.smoothscroll = true -- 平滑滚动

-- 补全设置
opt.completeopt = { "menu", "menuone", "noselect" } -- 补全菜单选项
opt.clipboard = "unnamedplus" -- 使用系统剪贴板

-- 鼠标设置
opt.mouse = "a" -- 允许在 Neovim 中使用鼠标

-- 折叠设置
opt.foldlevel = 99 -- 折叠级别设置
opt.foldmethod = "expr" -- 折叠方法使用表达式
opt.foldtext = "" -- 不显示折叠文本

-- 窗口标题设置
opt.title = true -- 启用窗口标题
opt.titlestring = "neovim" -- 窗口标题字符串

-- Shell 设置
opt.shell = "nu" -- Shell 设置为 Nushell
opt.shellcmdflag = "-c" -- Nushell 使用 -c 标志运行命令
opt.shellxquote = "" -- 避免额外的引号干扰
