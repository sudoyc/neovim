vim.api.nvim_create_autocmd({"BufNewFile"}, {
  pattern = { "*.cpp" },
  command = "0r ~/.skeleton.cpp | $delete | normal gg"
})

vim.api.nvim_create_autocmd({"BufNewFile"}, {
  pattern = { "*.c" },
  command = "0r ~/.skeleton.c | $delete | normal gg"
})
return {}
