return {
  { "folke/tokyonight.nvim" },
  { 'wakatime/vim-wakatime', lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    -- lazy = true,
    -- event = "VeryLazy",
    build = ":TSUpdate"
  },
  -- import = "plugins.blink",
}
