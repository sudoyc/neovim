return {
  run = function(exec)
    local cmd = vim.fn.system
    if vim.fn.filereadable("/tmp/kitty-nvim") == 0 then
      cmd("kitty --detach --listen-on unix:/tmp/kitty-nvim")
      vim.wait(500)
    else
      cmd("kitty @ --to unix:/tmp/kitty-nvim send-text "..'"'..exec..'\n"')
    end
  end
}
