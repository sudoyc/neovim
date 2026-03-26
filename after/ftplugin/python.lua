local utils = require("utils")

local function run_python(io_mode)
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  local cmd = ('cd "%s" && clear && python "%s"'):format(dir, file)
  if io_mode == "input" then
    cmd = cmd .. " < input.txt"
  elseif io_mode == "input_output" then
    cmd = cmd .. " < input.txt > output.txt"
  end
  utils.run(cmd)
end

vim.b.run_command = function()
  local last = utils.get_last_run("python")
  if last then
    run_python(last.io_mode)
  else
    run_python("direct")
  end
end

vim.b.pick_run = function()
  utils.pick("运行方式", {
    { text = "直接运行",                  io_mode = "direct" },
    { text = "< input.txt",              io_mode = "input" },
    { text = "< input.txt > output.txt", io_mode = "input_output" },
  }, function(item)
    utils.set_last_run("python", { io_mode = item.io_mode })
    run_python(item.io_mode)
  end)
end
