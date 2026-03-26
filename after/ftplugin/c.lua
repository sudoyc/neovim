local utils = require("utils")

vim.b.run_command = function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  local cmd = ('clear') .. '&&' ..
      ('cd ' .. '"' .. dir .. '"') .. '&&' ..
      ('clear') .. '&&' ..
      ('gcc "' .. file .. '" -O2 -fsanitize=address,undefined') .. '&&' ..
      ('echo build done') .. '&&'
  if vim.fn.filereadable("input.txt") == 1 then
    cmd = cmd .. ("./a.out < input.txt > output.txt")
  else
    cmd = cmd .. ("./a.out")
  end
  utils.run(cmd)
end
