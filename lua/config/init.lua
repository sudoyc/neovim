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
  cinoptions     = "g0l1Ls(0",
  splitbelow     = true,
  splitright     = true,
}

for key, val in pairs(M) do
  vim.o[key] = val
end

require("config.lazy")

vim.cmd.colorscheme("tokyonight")

vim.lsp.enable("clangd")

return {}
