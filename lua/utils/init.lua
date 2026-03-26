local M = {}

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

function M.compile_and_run(compiler, flags)
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:p")
  local cmd = ('clear && cd "%s" && clear && %s "%s" %s && echo build done && '):format(dir, compiler, file, flags)
  if vim.fn.filereadable(dir .. "/input.txt") == 1 then
    cmd = cmd .. "./a.out < input.txt > output.txt"
  else
    cmd = cmd .. "./a.out"
  end
  M.run(cmd)
end

return M
