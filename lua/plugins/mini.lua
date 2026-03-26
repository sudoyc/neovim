return {
  {
    'nvim-mini/mini.pairs',
    version = false,
    event = "VeryLazy",
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
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',

        suffix_last = 'l',
        suffix_next = 'n',
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
