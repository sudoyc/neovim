-- /home/stevearc/.config/nvim/lua/overseer/template/user/cpp_build.lua
return {
  name = "g++ build",
  builder = function()
    local file = vim.fn.expand("%:p")
    local name_only = vim.fn.expand("%:p:r")
    return {
      name = "g++ build",
      cmd = { "g++" },
      args = { file, "-o", name_only},
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
