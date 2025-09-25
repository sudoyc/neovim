vim.g.mapleader = " "

local set = vim.keymap.set

set("n", "<leader>l", "<C-w>l")
set("n", "<leader>j", "<C-w>j")
set("n", "<leader>h", "<C-w>h")
set("n", "<leader>k", "<C-w>k")

set("n", "<leader>v", "<C-w>v")
set("n", "<leader>s", "<C-w>s")

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

set("n", "<leader>b", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  toggleterm.exec("clear")
  toggleterm.exec("cd "..dir)
  toggleterm.exec("g++ "..file.." -O2 -fsanitize=address && ./a.out < input.txt > output.txt")
end)

set("n", "<leader>y", "\"+y")

return {}
