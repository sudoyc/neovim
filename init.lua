if vim.g.vscode then
  return
end
-- vim.o.guifont = "Monaspace Argon NF:h12"
-- vim.g.neovide_font_options = "+ss01, +ss02, +ss03, +ss04, +ss05, +ss06, +ss07, +ss08, +ss09, +ss10, +calt"

require("config")
require("keymap")
require("autocmd")
