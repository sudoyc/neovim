local M = {
  number         = true,
  relativenumber = true,
  expandtab      = true,
  smartindent    = true,
  autoindent     = true,
  wrap           = false,
  cul            = true,
  tabstop        = 2,
  mouse          = "a",
  undofile       = true,
  shiftwidth     = 2,
  termguicolors  = true,
  backup         = false,
  expandtab      = true,
  hlsearch       = false,
  backup         = true,
  updatetime     = 1000,
  signcolumn     = "yes",
  cinoptions     = "g0l1Ls(0j1,(0,ws,Ws",
  splitbelow     = true,
  splitright     = true,
  -- guicursor      = "",
}

for key, val in pairs(M) do
  vim.o[key] = val
end

require("config.lazy")

vim.cmd.colorscheme("tokyonight")

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "LspDiagnosticsSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

-- local sign = { Error = '', Hint = 'ﴞ', Info = '', Warn = '', }
-- for name_, text_ in pairs(sign) do
--   local set_sign = vim.fn.sign_define
--   local temp = "DiagnosticSign" .. name_
--   set_sign(temp, {text = text_, texthl = temp, numhl = 'DiagnosticDefault' .. name_})
-- end

vim.diagnostic.config({
  virtual_text = {
    enable = true,
  },
  virtual_lines = {
    enable = true,
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.INFO] = signs.Info,
      [vim.diagnostic.severity.HINT] = signs.Hint,
    },
  }
})

-- 自动刷新缓冲区
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

return {}
