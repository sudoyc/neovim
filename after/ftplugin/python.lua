local utils = require("utils")

vim.b.run_command = function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  local cmd = ('cd "%s" && clear && python "%s"'):format(dir, file)
  if _G.use_input and _G.use_output then
    cmd = cmd .. " < input.txt > output.txt"
  elseif _G.use_input then
    cmd = cmd .. " < input.txt"
  end
  utils.run(cmd)
end
