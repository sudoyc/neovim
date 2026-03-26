return {
  "folke/snacks.nvim",
  dependencies = { "3rd/image.nvim" },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  config = function()
    local opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      animate = { enabled = false, },
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
      },
      explorer = { enabled = true },
      -- indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      toggle = { enabled = true },
      scratch = { enabled = true },
      rename = { enabled = true },
      image = { enabled = true },
    }
    require("snacks").setup(opts)
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "SnacksDashboardOpened",
    --   callback = function(ev)
    --     local image_api = require("image")
    --
    --     -- 这里的 path 记得改成你自己的，别又报错来找我喵！
    --     local img = image_api.from_file("/home/ycyc/wallpaper/wallpaper.jpg", {
    --       -- window = ev.buf, -- 绑定到当前的 dashboard buffer
    --       x = 2,      -- 左右偏移，建议根据你的仪表盘宽度微调
    --       y = 2,       -- 上下偏移
    --       -- width = 50,
    --       -- height = 20,
    --     })
    --
    --     img:render()
    --
    --     -- print("now you get a image")
    --
    --     -- if img then
    --     --   img:render() -- <--- 咒语在这里！喵！！！
    --     -- end
    --     --
    --     -- -- 当切换 buffer 或者关闭 dashboard 时，要把图片毁尸灭迹
    --     -- vim.api.nvim_create_autocmd("BufLeave", {
    --     --   buffer = ev.buf,
    --     --   callback = function()
    --     --     if img then img:delete() end
    --     --   end,
    --     --   once = true,
    --     -- })
    --   end,
    -- })
  end,
  keys = {
    -- find
    { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
    { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files({ cwd = "~/" }) end,                     desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
    -- grep buffers
    { "<leader>gg", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
    { "<leader>gb", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
    { "<leader>gw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
    -- toggle
    { "<leader>ti", function() Snacks.toggle({ name = "Input (input.txt)", get = function() return _G.use_input end, set = function(v) _G.use_input = v; require("utils").save_build_config() end }):toggle() end, desc = "Toggle input.txt" },
    { "<leader>to", function() Snacks.toggle({ name = "Output (output.txt)", get = function() return _G.use_output end, set = function(v) _G.use_output = v; require("utils").save_build_config() end }):toggle() end, desc = "Toggle output.txt" },
    -- scratch
    { "<leader>os", function() Snacks.scratch() end, desc = "Scratch Buffer" },
    -- rename file
    { "<leader>mv", function() Snacks.rename.rename_file() end, desc = "Rename File" },
  }
}
