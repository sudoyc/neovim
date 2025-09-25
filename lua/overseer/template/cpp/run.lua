return {
  name = "g++ run",
  builder = function()
    local file = vim.fn.expand("%:p")
    local name_only = vim.fn.expand("%:p:r")
    return {
      name = "g++ run",
      cmd = { name_only },
      args = { "<", "input.txt"},
      components = {
        {
          "dependencies",
          task_names = {
            "g++ build",
          },
          sequential = true,
        },
        {
          "on_output_quickfix", open = true
        },
        "default"
      },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
