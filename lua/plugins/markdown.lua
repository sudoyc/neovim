return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  config = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browser = 'C:Program Files\\Google\\Chrome\\Application\\chrome.exe'
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browser = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
  end,
  ft = { "markdown" },
}
