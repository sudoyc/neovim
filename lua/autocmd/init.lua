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
    -- local file = event.match
    local file = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.simplify(vim.fn.fnamemodify(file, ":p:h"))
    -- print(dir);
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
    -- vim.cmd("silent lcd " .. dir)
  end,
})

-- 设定当前window的目录为文件目录
vim.api.nvim_create_autocmd({"BufWinEnter", "BufEnter"}, {
  callback = function(event)
    if vim.fn.filereadable(event.match) == 0 then
      return
    end
    local dir = vim.fn.simplify(vim.fn.expand("%:h"))
    if dir ~= "" then
      vim.cmd("silent lcd " .. dir)
    end
  end
})

_G.terminal_startinsert_able = true

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if not vim.api.nvim_buf_is_valid(0) then return end
    local bt = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    if bt == "terminal" and terminal_startinsert_able == true then
      vim.cmd("startinsert")
    end
  end,
})

return {}
