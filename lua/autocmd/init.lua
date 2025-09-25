vim.api.nvim_create_autocmd({"BufNewFile"}, {
  pattern = { "*.cpp" },
  command = ":0r ~/.skeleton.cpp"
})
return {}
