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
    local dir = vim.fn.fnamemodify(event.match, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- 设定当前 window 的目录为文件目录
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(event)
    if vim.bo[event.buf].buftype ~= "" then return end
    local file = event.match
    if vim.fn.filereadable(file) == 0 then return end
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if dir ~= "" then
      vim.cmd("silent lcd " .. vim.fn.fnameescape(dir))
    end
  end,
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
