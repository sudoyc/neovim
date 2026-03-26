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

-- something for lsp
set("n", "<leader>nn", function()
  vim.ui.input(
    { prompt = "input the new name" },
    function (str)
      if str then
        vim.lsp.buf.rename(str)
      end
    end
  )
end, { noremap = true, silent = true })
-- set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })

-- something for terminal
set("n", "<leader>tt", function ()
  term:toggle()
end, { noremap = true, silent = true });
set("n", "<leader>to", function ()
  term:open()
end, { noremap = true, silent = true });
set({"n", "t"}, "<C-t>", function ()
  term:toggle()
end, { noremap = true, silent = true });

set("n", "<leader>v", "<C-w>v")
set("n", "<leader>s", "<C-w>s")

set("n", "<leader>q", "<C-w>q")

set("n", "<leader>w", "<Cmd>w<CR>", { noremap = true, silent = true })
-- set("n", "<leader>w", function()
--   local old = vim.o.lazyredraw
--   -- vim.api.nvim_command("write")
--   vim.o.lazyredraw = true
--   vim.cmd("silent write")
--   vim.o.lazyredraw = old
-- end, { noremap = true, silent = true })

for i = 1, 9, 1 do
  set("n", "<leader>" .. i, i .. "<C-w><C-w>")
end

set("n", "<leader>i", function()
  vim.cmd("CompetiTest run")
end)

set("n", "<leader>c", function()
  vim.cmd("CompetiTest receive testcases")
end)

-- local toggleterm = require("toggleterm")

-- local function run(exec)
--   local cmd = vim.fn.system
--   if vim.fn.filereadable("/tmp/kitty-nvim") == 0 then
--     cmd("kitty --detach --listen-on unix:/tmp/kitty-nvim")
--     vim.wait(500)
--   else
--     cmd("kitty @ --to unix:/tmp/kitty-nvim send-text "..'"'..exec..'\n"')
--   end
-- end

set("n", "<leader>b", function()
  vim.cmd("cd %:h")
  if (vim.b.run_command ~= nil) then
    vim.b.run_command()
  end
end, {
  silent = true,
  noremap = true,
})

set("n", "<leader>ft", function()
  vim.lsp.buf.format({ async = true })
end, {
  silent = true,
  noremap = true,
})


set({"n", "v"}, "<leader>y", "\"+y")
set({"n", "v"}, "<leader>p", "\"+p")

return {}
