vim.b.run_command = function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  require("utils").run(('cd "%s" && clear && python "%s"'):format(dir, file))
end
