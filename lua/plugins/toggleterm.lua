return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    _G.term = require("toggleterm.terminal").Terminal:new({
      cmd = "zsh",
      hidden = true,
      close_on_exit = false,
      on_exit = function(t)
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then
            -- 最后一个窗口，直接退出 nvim
            vim.cmd("qa!")
          else
            t:close()
            if t.bufnr and vim.api.nvim_buf_is_loaded(t.bufnr) then
              vim.api.nvim_buf_delete(t.bufnr, { force = true })
            end
          end
        end)
      end,
    })
  end
}
