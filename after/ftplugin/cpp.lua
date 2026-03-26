local utils = require("utils")

vim.b.run_command = function()
  local last = utils.get_last_run("cpp")
  if last then
    utils.compile_and_run(last.compiler, last.flags, last.io_mode)
  else
    utils.compile_and_run("g++", "-std=" .. _G.cpp_std .. " -O2 -fsanitize=address,undefined")
  end
end

vim.b.pick_std = function()
  utils.pick("C++ 标准 (当前: " .. _G.cpp_std .. ")", {
    { text = "C++23", std = "c++23" },
    { text = "C++20", std = "c++20" },
    { text = "C++17", std = "c++17" },
    { text = "C++14", std = "c++14" },
  }, function(item)
    _G.cpp_std = item.std
    utils.set_last_run("cpp", nil)
    local dir = vim.fn.expand("%:p:h")
    vim.fn.writefile({ "-std=" .. item.std }, dir .. "/compile_flags.txt")
    vim.notify("已设置 " .. item.text .. "，正在重启 clangd...", vim.log.levels.INFO)
    utils.restart_clangd()
  end)
end

vim.b.pick_run = function()
  local std = "-std=" .. _G.cpp_std
  utils.pick("运行方式", {
    { text = "OJ模式 + input.txt  (-O2 -DONLINE_JUDGE)",  compiler = "g++", flags = std .. " -O2 -DONLINE_JUDGE", io_mode = "input_output" },
    { text = "OJ模式 + 直接运行   (-O2 -DONLINE_JUDGE)",  compiler = "g++", flags = std .. " -O2 -DONLINE_JUDGE", io_mode = "direct" },
    { text = "Debug + sanitizer + 直接运行",               compiler = "g++", flags = std .. " -g -fsanitize=address,undefined", io_mode = "direct" },
    { text = "Debug + sanitizer + input.txt",              compiler = "g++", flags = std .. " -g -fsanitize=address,undefined", io_mode = "input_output" },
    { text = "Release (-O3) + 直接运行",                   compiler = "g++", flags = std .. " -O3", io_mode = "direct" },
    { text = "仅编译",                                     compiler = "g++", flags = std .. " -O2", io_mode = "compile_only" },
  }, function(item)
    utils.set_last_run("cpp", { compiler = item.compiler, flags = item.flags, io_mode = item.io_mode })
    utils.compile_and_run(item.compiler, item.flags, item.io_mode)
  end)
end
