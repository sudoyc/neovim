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
local function lcd_to_file(buf)
  if vim.bo[buf].buftype ~= "" then return end
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then return end

  -- 先转成绝对路径，再消除路径中的 .. 和 . 以及符号链接
  file = vim.fn.resolve(vim.fn.simplify(vim.fn.fnamemodify(file, ":p")))

  local dir = vim.fn.fnamemodify(file, ":h")
  if dir ~= "" and vim.fn.isdirectory(dir) == 1 then
    vim.cmd("silent lcd " .. vim.fn.fnameescape(dir))
  end
end

-- BufReadPost：已有文件读完后；BufNewFile：新建文件确定路径后；BufEnter：切换 buffer 时
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
  callback = function(event) lcd_to_file(event.buf) end,
})

-- 进入终端自动 insert 模式（已禁用）
-- _G.terminal_startinsert_able = true
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     if not vim.api.nvim_buf_is_valid(0) then return end
--     local bt = vim.api.nvim_get_option_value("buftype", { buf = 0 })
--     if bt == "terminal" and terminal_startinsert_able == true then
--       vim.cmd("startinsert")
--     end
--   end,
-- })

-- 恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 锁定 toggleterm 窗口高度
vim.api.nvim_create_autocmd("FileType", {
  pattern = "toggleterm",
  callback = function()
    vim.wo.winfixheight = true
  end,
})

-- 自动刷新缓冲区（基于 libuv fs_event）
local watchers = {}

local function watch_buf(bufnr)
  if watchers[bufnr] then return end
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" or vim.fn.filereadable(path) == 0 then return end

  local handle = vim.uv.new_fs_event()
  if not handle then return end

  handle:start(path, {}, vim.schedule_wrap(function(err, _, _)
    if err then return end
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("checktime")
      end)
    end
  end))

  watchers[bufnr] = handle
end

local function unwatch_buf(bufnr)
  local handle = watchers[bufnr]
  if handle then
    handle:stop()
    handle:close()
    watchers[bufnr] = nil
  end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
  callback = function(ev) watch_buf(ev.buf) end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  callback = function(ev) unwatch_buf(ev.buf) end,
})

return {}
