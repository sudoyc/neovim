vim.b.run_command = function()
  require("utils").compile_and_run("g++", "-O2 -std=c++20 -fsanitize=address,undefined")
end
