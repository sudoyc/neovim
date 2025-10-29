local M = {
  wrap           = true,
  relativenumber = false,
}

for key, val in pairs(M) do
  vim.opt_local[key] = val
end
