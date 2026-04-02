return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" },
  opts = {
    terminal_cmd = vim.fn.expand("~/.npm-global/bin/claude"),
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
      provider = "snacks",
      -- 让 Claude Code 以 git 根目录为 cwd，而不是跟着 lcd 跳
      cwd_provider = function(ctx)
        return require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd)
      end,
    },
    track_selection = true,
  },
  keys = {
    { "<leader>ac", "<Cmd>ClaudeCode<CR>",            desc = "Toggle Claude" },
    { "<leader>af", "<Cmd>ClaudeCodeFocus<CR>",       desc = "Focus Claude" },
    { "<leader>ar", "<Cmd>ClaudeCode --resume<CR>",   desc = "Resume Claude" },
    { "<leader>as", "<Cmd>ClaudeCodeSend<CR>",        mode = "v", desc = "Send selection" },
    { "<leader>ab", "<Cmd>ClaudeCodeAdd %<CR>",       desc = "Add current buffer" },
    { "<leader>aa", "<Cmd>ClaudeCodeDiffAccept<CR>",  desc = "Accept diff" },
    { "<leader>ad", "<Cmd>ClaudeCodeDiffDeny<CR>",    desc = "Reject diff" },
  },
}
