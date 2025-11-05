local utils = require("utils")

vim.b.run_command = function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  utils.run("cd "..'\\"'..dir..'\\"')
  utils.run('clear')
  utils.run("python " .. file)
end
