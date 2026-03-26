return {
  run = function(exec)
    _G.terminal_startinsert_able = false
    if term:is_open() == false then
      term:open()
      -- vim.schedule(function()
      --   vim.cmd("wincmd p")
      -- end)
      -- vim.api.nvim_feedkeys(
      --   vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
      --   "n",
      --   true
      -- )
      -- vim.cmd("wincmd p")
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
}
