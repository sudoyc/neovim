local M = {
  scrolloff      = 5,
  cmdheight      = 0,
  virtualedit    = "onemore",
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
  backup         = true,
  hlsearch       = false,
  updatetime     = 1000,
  signcolumn     = "yes",
  cinoptions     = "g0l1Ls(0j1,(0,ws,Ws",
  splitbelow     = true,
  splitright     = true,
  autoread       = true,
  pumblend       = 10,
}

for key, val in pairs(M) do
  vim.o[key] = val
end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.wildoptions:append('pum')

require("config.lazy")

vim.cmd.colorscheme("tokyonight")

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")

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
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  }
})

return {}
