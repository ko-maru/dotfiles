for k, v in pairs({
  clipboard = "unnamedplus",
  expandtab = true,
  mouse = "a",
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  smartindent = true,
  wildmode = "list:longest"
}) do
  vim.opt[k] = v
end

if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
  -- vim.cmd.colorscheme("everforest")
end
