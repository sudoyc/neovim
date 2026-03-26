local utils = require("utils")

local std_map = {
  ["c++23"] = "c23",
  ["c++20"] = "c17",
  ["c++17"] = "c17",
  ["c++14"] = "c11",
}

local function c_std()
  return "-std=" .. (std_map[_G.cpp_std] or "c17")
end

vim.b.run_command = function()
  local last = utils.get_last_run("c")
  if last then
    utils.compile_and_run(last.compiler, last.flags, last.io_mode)
  else
    utils.compile_and_run("gcc", c_std() .. " -O2 -fsanitize=address,undefined")
  end
end

vim.b.pick_std = function()
  utils.pick("C/C++ 标准 (当前: " .. _G.cpp_std .. ")", {
    { text = "C++23 / C23", std = "c++23" },
    { text = "C++20 / C17", std = "c++20" },
    { text = "C++17 / C17", std = "c++17" },
    { text = "C++14 / C11", std = "c++14" },
  }, function(item)
    _G.cpp_std = item.std
    utils.set_last_run("c", nil)
    local dir = vim.fn.expand("%:p:h")
    vim.fn.writefile({ "-std=" .. (std_map[item.std] or "c17") }, dir .. "/compile_flags.txt")
    vim.notify("已设置 " .. item.text .. "，正在重启 clangd...", vim.log.levels.INFO)
    utils.restart_clangd()
  end)
end

vim.b.pick_run = function()
  local std = c_std()
  utils.pick("运行方式", {
    { text = "Debug + sanitizer + 直接运行",   compiler = "gcc", flags = std .. " -g -fsanitize=address,undefined", io_mode = "direct" },
    { text = "Debug + sanitizer + input.txt",  compiler = "gcc", flags = std .. " -g -fsanitize=address,undefined", io_mode = "input_output" },
    { text = "Release (-O2) + 直接运行",       compiler = "gcc", flags = std .. " -O2", io_mode = "direct" },
    { text = "Release (-O3) + 直接运行",       compiler = "gcc", flags = std .. " -O3", io_mode = "direct" },
    { text = "仅编译",                         compiler = "gcc", flags = std .. " -O2", io_mode = "compile_only" },
  }, function(item)
    utils.set_last_run("c", { compiler = item.compiler, flags = item.flags, io_mode = item.io_mode })
    utils.compile_and_run(item.compiler, item.flags, item.io_mode)
  end)
end
