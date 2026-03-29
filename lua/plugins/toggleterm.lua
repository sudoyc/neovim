return {
  'akinsho/toggleterm.nvim',
  version = "*",
  lazy = false,
  keys = {
    { "<C-t>", function() run_term:toggle() end, mode = {"n"}, desc = "Toggle run terminal" },
    { "<leader>t", function() _G.toggle_shell_term(vim.v.count ~= 0 and vim.v.count or nil) end, mode = {"n"}, desc = "Toggle shell terminal" },
  },
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    local function make_on_exit(t)
      return function()
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then
            vim.cmd("qa!")
          else
            t:close()
            if t.bufnr and vim.api.nvim_buf_is_loaded(t.bufnr) then
              vim.api.nvim_buf_delete(t.bufnr, { force = true })
            end
          end
        end)
      end
    end

    _G.run_term = Terminal:new({
      cmd = "zsh",
      hidden = true,
      close_on_exit = false,
      on_exit = make_on_exit(_G.run_term),
    })
    -- 修正 on_exit 引用（Terminal:new 时 _G.run_term 尚未赋值）
    _G.run_term.on_exit = make_on_exit(_G.run_term)

    _G.shell_terms = {}
    _G.last_shell_id = 1

    _G.toggle_shell_term = function(id)
      id = id or _G.last_shell_id
      _G.last_shell_id = id
      if not _G.shell_terms[id] then
        local t = Terminal:new({ cmd = "zsh", hidden = true, close_on_exit = false })
        _G.shell_terms[id] = t
        t.on_exit = make_on_exit(t)
      end
      _G.shell_terms[id]:toggle()
    end
  end
}
