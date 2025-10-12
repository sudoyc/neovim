return {
  {
    'nvim-mini/mini.pairs',
    version = false,
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    'nvim-mini/mini.surround',
    version = false, -- main 分支
    event = "VeryLazy",
    opts = {
      mappings = {
        add = '<leader>a', -- Add surrounding in Normal and Visual modes
        delete = '<leader>d', -- Delete surrounding
        find = '<leader>f', -- Find surrounding (to the right)
        find_left = '<leader>F', -- Find surrounding (to the left)
        highlight = '<leader>h', -- Highlight surrounding
        replace = '<leader>r', -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
  },
  {
    'nvim-mini/mini.splitjoin',
    event = "VeryLazy",
    config = function()
      require("mini.splitjoin").setup()
    end
  },
  {
    'nvim-mini/mini.comment',
    version = false,
    event = "VeryLazy",
    config = function ()
      require("mini.comment").setup()
    end
  },
}
