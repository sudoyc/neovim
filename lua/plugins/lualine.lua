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
          statusline = { "toggleterm" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { window, 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype', get_words },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = { window, 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
