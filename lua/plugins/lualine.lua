return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  -- event = "BufEnter",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local window = function()
      return vim.api.nvim_win_get_number(0)
    end
    local get_words = function()
      local wc = vim.fn.wordcount()
      -- visual_chars 是为了在可视化模式下选中文本时，实时显示选中了多少字
      local count = wc.visual_chars or wc.chars
      return "Chars: " .. count
    end
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = { "toggleterm", "snacks_terminal", "snacks_picker_list", "snacks_picker_input", "snacks_picker_preview" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {},
        lualine_x = { 'encoding', 'fileformat', 'filetype', get_words },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {
        lualine_a = { window },
        lualine_b = { { 'filename', path = 1, fmt = function(str) return vim.fn.fnamemodify(vim.fn.resolve(vim.fn.simplify(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p"))), ":~:.") end } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_winbar = {
        lualine_a = { window },
        lualine_b = { { 'filename', path = 1, fmt = function(str) return vim.fn.fnamemodify(vim.fn.resolve(vim.fn.simplify(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p"))), ":~:.") end } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {}
    }
  end
}
