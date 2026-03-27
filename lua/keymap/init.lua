vim.g.mapleader = " "

local set = vim.keymap.set

vim.keymap.set("n", "<Space>", "<Nop>")

set("n", "<a-l>", "<C-w>l")
set("n", "<a-j>", "<C-w>j")
set("n", "<a-h>", "<C-w>h")
set("n", "<a-k>", "<C-w>k")

set("t", "<a-l>", "<C-\\><C-n><C-w>l")
set("t", "<a-j>", "<C-\\><C-n><C-w>j")
set("t", "<a-h>", "<C-\\><C-n><C-w>h")
set("t", "<a-k>", "<C-\\><C-n><C-w>k")

set("n", "<leader>v", "<C-w>v")
set("n", "<leader>s", "<C-w>s")

set("n", "<leader>q", "<C-w>q")

set("n", "<leader>w", "<Cmd>w<CR>", { noremap = true, silent = true })

for i = 1, 9, 1 do
  set("n", "<leader>" .. i, i .. "<C-w><C-w>")
end

set("n", "<leader>r", function()
  vim.cmd("cd %:h")
  if (vim.b.run_command ~= nil) then
    vim.b.run_command()
  end
end, {
  silent = true,
  noremap = true,
})

set("n", "<leader>R", function()
  vim.cmd("cd %:h")
  if vim.b.pick_run ~= nil then
    vim.b.pick_run()
  end
end, { silent = true, noremap = true })

set("n", "<leader>S", function()
  if vim.b.pick_std ~= nil then
    vim.b.pick_std()
  end
end, { silent = true, noremap = true })

set("n", "<leader>F", function()
  vim.lsp.buf.format({ async = true })
end, {
  silent = true,
  noremap = true,
})

set({"n", "v"}, "<leader>y", "\"+y")
set({"n", "v"}, "<leader>p", "\"+p")

return {}
