local M = {}

local config_path = vim.fn.stdpath("config") .. "/.build_config.lua"

function M.load_build_config()
  local ok, cfg = pcall(dofile, config_path)
  if ok and cfg then
    _G.cpp_std = cfg.cpp_std or "c++20"
    _G.last_run = cfg.last_run or nil
  else
    _G.cpp_std = _G.cpp_std or "c++20"
    _G.last_run = _G.last_run or nil
  end
end

function M.save_build_config()
  local content = "return " .. vim.inspect({
    cpp_std = _G.cpp_std,
    last_run = _G.last_run,
  }) .. "\n"
  vim.fn.writefile(vim.split(content, "\n"), config_path)
end

M.load_build_config()

function M.run(exec)
  _G.terminal_startinsert_able = false
  if term:is_open() == false then
    term:open()
  end
  term:send(exec)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
    "n",
    true
  )
  vim.cmd("wincmd p")
  _G.terminal_startinsert_able = true
end

function M.compile_and_run(compiler, flags, io_mode)
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  local cmd = ('clear && cd "%s" && clear && %s "%s" %s && echo build done && '):format(dir, compiler, file, flags)
  if io_mode == "input" then
    cmd = cmd .. "./a.out < input.txt"
  elseif io_mode == "input_output" then
    cmd = cmd .. "./a.out < input.txt > output.txt"
  elseif io_mode == "compile_only" then
    cmd = cmd .. "echo done"
  else
    cmd = cmd .. "./a.out"
  end
  M.run(cmd)
end

-- 通用 picker
function M.pick(title, items, on_confirm)
  Snacks.picker.pick({
    title = title,
    items = items,
    format = function(item) return { { item.text } } end,
    confirm = function(picker, item)
      picker:close()
      on_confirm(item)
    end,
  })
end

-- 重启 clangd（原生 LSP）
function M.restart_clangd()
  local clients = vim.lsp.get_clients({ name = "clangd" })
  for _, client in ipairs(clients) do
    local bufs = vim.lsp.get_buffers_by_client_id(client.id)
    client:stop()
    vim.defer_fn(function()
      for _, buf in ipairs(bufs) do
        vim.lsp.start(vim.lsp.config.clangd, { bufnr = buf })
      end
    end, 500)
  end
end

return M
