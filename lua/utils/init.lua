local M = {}

function M.is_remote()
  if vim.env.SSH_TTY ~= nil or (vim.env.WEZTERM_EXECUTABLE ~= nil and vim.env.XDG_RUNTIME_DIR ~= nil) then
    return true
  else
    return false
  end
end

function M.has_pack_plugin(name)
  local list = vim.pack.get({name}, {info = false}) -- 只查一个，轻量
  return list and list[1] and vim.fn.isdirectory(list[1].path) == 1
end

return M
