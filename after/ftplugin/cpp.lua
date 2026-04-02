local utils = require("utils")

vim.b.run_command = function()
  local last = utils.get_last_run("cpp")
  if last then
    utils.compile_and_run(last.compiler, last.flags)
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
  utils.pick("编译方式", {
    { text = "OJ模式  (-O2 -DONLINE_JUDGE)",       compiler = "g++", flags = std .. " -O2 -DONLINE_JUDGE" },
    { text = "Debug + sanitizer",                  compiler = "g++", flags = std .. " -g -fsanitize=address,undefined" },
    { text = "Release (-O3)",                      compiler = "g++", flags = std .. " -O3" },
    { text = "仅编译  (-O2)",                      compiler = "g++", flags = std .. " -O2", compile_only = true },
  }, function(item)
    utils.set_last_run("cpp", { compiler = item.compiler, flags = item.flags, compile_only = item.compile_only })
    if item.compile_only then
      vim.cmd("silent! write")
      local file = vim.fn.resolve(vim.fn.simplify(vim.fn.fnamemodify(vim.fn.expand("%:p"), ":p")))
      local dir = vim.fn.fnamemodify(file, ":h")
      utils.run(('clear && cd "%s" && clear && %s "%s" %s && echo build done'):format(dir, item.compiler, file, item.flags))
    else
      utils.compile_and_run(item.compiler, item.flags)
    end
  end)
end
