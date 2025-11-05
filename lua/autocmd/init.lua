vim.api.nvim_create_autocmd({"BufNewFile"}, {
  pattern = { "*.cpp" },
  command = "0r ~/.skeleton.cpp | $delete | normal gg"
})

vim.api.nvim_create_autocmd({"BufNewFile"}, {
  pattern = { "*.c" },
  command = "0r ~/.skeleton.c | $delete | normal gg"
})

-- 自动创建父目录
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    local file = event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
    vim.cmd("lcd " .. dir)
  end,
})

-- 设定当前window的目录为文件目录
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(event)
    if vim.fn.filereadable(event.match) == 0 then
      return
    end
    local dir = vim.fn.expand("%:h")
    if dir ~= "" then
      vim.cmd("lcd " .. dir)
    end
  end
})

return {}
