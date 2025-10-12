vim.g.mapleader = " "

local set = vim.keymap.set

set("n", "<a-l>", "<C-w>l")
set("n", "<a-j>", "<C-w>j")
set("n", "<a-h>", "<C-w>h")
set("n", "<a-k>", "<C-w>k")

set("n", "<leader>v", "<C-w>v")
set("n", "<leader>s", "<C-w>s")

set("n", "<leader>q", "<C-w>q")

for i=1,9,1 do
  set("n", "<leader>"..i, i.."<C-w><C-w>")
end

set("n", "<leader>r", function()
  vim.cmd("CompetiTest run")
end)

set("n", "<leader>c", function()
  vim.cmd("CompetiTest receive testcases")
end)

local toggleterm = require("toggleterm")

local function run(exec)
  local cmd = vim.fn.system
  if vim.fn.filereadable("/tmp/kitty-nvim") == 0 then
    cmd("kitty --detach --listen-on unix:/tmp/kitty-nvim")
    vim.wait(500)
  else
    cmd("kitty @ --to unix:/tmp/kitty-nvim send-text "..'"'..exec..'\n"')
  end
end

set("n", "<leader>b", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  run("cd "..'\\"'..dir..'\\"')
  run('clear')
  run("g++ "..'\\"'..file..'\\"'.." -O2 -fsanitize=address,undefined")
  if vim.fn.filereadable("input.txt") == 1 then
    run("./a.out < input.txt > output.txt")
  else
    run("./a.out")
  end
end)

-- set("n", "<leader>b", function()
  --   local dir = vim.fn.expand("%:p:h")
  --   local file = vim.fn.expand("%:p")
  --   toggleterm.exec("clear")
  --   toggleterm.exec("cd "..dir)
  --   toggleterm.exec("g++ "..file.." -O2 -fsanitize=address && ./a.out < input.txt > output.txt")
  -- end)

  set("n", "<leader>y", "\"+y")

  return {}
