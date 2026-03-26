return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    _G.term = require("toggleterm.terminal").Terminal:new({ cmd = "zsh", hidden = true })
  end
  -- lazy = true,
}
