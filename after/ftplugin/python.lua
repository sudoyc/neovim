local utils = require("utils")

vim.b.run_command = function()
  if _G.last_run and _G.last_run.lang == "python" then
    local dir = vim.fn.expand("%:p:h")
    local file = vim.fn.expand("%:p")
    local cmd = ('cd "%s" && clear && python "%s"'):format(dir, file)
    if _G.last_run.io_mode == "input" then
      cmd = cmd .. " < input.txt"
    elseif _G.last_run.io_mode == "input_output" then
      cmd = cmd .. " < input.txt > output.txt"
    end
    utils.run(cmd)
  else
    local dir = vim.fn.expand("%:p:h")
    local file = vim.fn.expand("%:p")
    utils.run(('cd "%s" && clear && python "%s"'):format(dir, file))
  end
end

vim.b.pick_run = function()
  utils.pick("运行方式", {
    { text = "直接运行",                  io_mode = "direct" },
    { text = "< input.txt",              io_mode = "input" },
    { text = "< input.txt > output.txt", io_mode = "input_output" },
  }, function(item)
    _G.last_run = { lang = "python", io_mode = item.io_mode }
    utils.save_build_config()
    local dir = vim.fn.expand("%:p:h")
    local file = vim.fn.expand("%:p")
    local cmd = ('cd "%s" && clear && python "%s"'):format(dir, file)
    if item.io_mode == "input" then
      cmd = cmd .. " < input.txt"
    elseif item.io_mode == "input_output" then
      cmd = cmd .. " < input.txt > output.txt"
    end
    utils.run(cmd)
  end)
end
