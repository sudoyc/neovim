vim.b.run_command = function()
  require("utils").compile_and_run("gcc", "-O2 -fsanitize=address,undefined")
end
