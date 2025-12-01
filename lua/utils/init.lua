--- @class UserUtils
--- @field icons utils.icons
--- @field lsp utils.lsp
local M = {}
setmetatable(M, {
	__index = function(t, k)
		t[k] = require("utils." .. k)
		return t[k]
	end,
})

function M.is_remote()
	if vim.env.SSH_TTY ~= nil or (vim.env.WEZTERM_EXECUTABLE ~= nil and vim.env.XDG_RUNTIME_DIR ~= nil) then
		return true
	else
		return false
	end
end

-- 判断某个插件是否启动
function M.has(name)
	local ok, plugins = pcall(vim.pack.get, { name })
	if not ok then
		return false -- 插件未安装或其他错误
	end
	return #plugins > 0 and plugins[1].active == true
end

-- 检查系统内存
function M.is_memory_less_than(gb)
	-- 默认值为 1GB
	gb = gb or 1

	-- 将 GB 转换为字节
	local threshold = gb * 1024 * 1024 * 1024

	-- 获取系统总内存
	local total_memory = vim.uv.get_total_memory()

	return total_memory < threshold
end

-- 检查可用内存
function M.is_available_memory_less_than(gb)
	gb = gb or 1
	local threshold = gb * 1024 * 1024 * 1024

	local available_memory = vim.uv.get_available_memory()

	return available_memory < threshold
end

-- 检查空闲内存
function M.is_free_memory_less_than_1gb(gb)
	gb = gb or 1
	local threshold = gb * 1024 * 1024 * 1024

	local free_memory = vim.uv.get_free_memory()

	return free_memory < threshold
end

return M
