if vim.g.vscode then
  return
end
vim.o.guifont = "Monaspace Argon NF:h12"

require("config")
require("keymap")
require("autocmd")
