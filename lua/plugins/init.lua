return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "storm",
      plugins = {
        -- enable all plugins when not using lazy.nvim
        -- set to false to manually enable/disable plugins
        all = package.loaded.lazy == nil,
        -- uses your plugin manager to automatically enable needed plugins
        -- currently only lazy.nvim is supported
        auto = true,
        flash = true,
        -- add any plugins here that you want to enable
        -- for all possible plugins, see:
        --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
        -- telescope = true,
      },
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
  },
  {
    'wakatime/vim-wakatime',
    event = "VeryLazy"
    -- lazy = false
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = 'master',
  --   -- lazy = true,
  --   -- event = "VeryLazy",
  --   build = ":TSUpdate"
  -- },
  -- import = "plugins.blink",
}
