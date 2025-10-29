local utils = require("utils")

vim.b.run_command = function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  utils.run("cd "..'\\"'..dir..'\\"')
  utils.run('clear')
  utils.run("g++ "..'\\"'..file..'\\"'.." -O2 -fsanitize=address,undefined")
  if vim.fn.filereadable("input.txt") == 1 then
    utils.run("./a.out < input.txt > output.txt")
  else
    utils.run("./a.out")
  end
end
